
require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { create(:user) }
  let(:venue) { create(:venue) }
  let(:event_type) { create(:event_type) }

  let(:base_start_time) { 3.days.from_now.change(min: 0) }
  let(:base_end_time) { base_start_time + 2.hours }

  let(:valid_event) do
    build(:event,
      user: user,
      venue: venue,
      event_type: event_type,
      start_time: base_start_time,
      end_time: base_end_time,
      event_date: base_start_time,
      event_end_date: base_end_time,
      early_bird_end_time: 2.days.from_now
    )
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(valid_event).to be_valid
    end

    it "is invalid without required fields" do
      event = Event.new
      expect(event).not_to be_valid
      expect(event.errors[:organizer_name]).to include("field can't be blank")
      expect(event.errors[:event_name]).to include("field can't be blank")
      expect(event.errors[:description]).to include("field can't be blank")
      expect(event.errors[:event_date]).to include("field can't be blank")
    end

    it "validates numericality of base_price and early_bird_price" do
      valid_event.base_price = 0
      valid_event.early_bird_price = -5
      expect(valid_event).not_to be_valid
      expect(valid_event.errors[:base_price]).to include("amount should be greater than 0")
      expect(valid_event.errors[:early_bird_price]).to include("amount should be greater than 0")
    end

    it "validates capacity is at least 30" do
      valid_event.capacity = 20
      expect(valid_event).not_to be_valid
      expect(valid_event.errors[:capacity]).to include("should be at least 30")
    end

    it "does not allow duplicate event_name" do
      create(:event, event_name: "Unique Event", user: user, venue: venue, event_type: event_type,
             start_time: base_start_time, end_time: base_end_time,
             event_date: base_start_time, event_end_date: base_end_time)
      duplicate_event = build(:event, event_name: "Unique Event", user: user, venue: venue, event_type: event_type,
                            start_time: base_start_time + 3.hours, end_time: base_end_time + 3.hours,
                            event_date: base_start_time + 3.hours, event_end_date: base_end_time + 3.hours)
      expect(duplicate_event).not_to be_valid
      expect(duplicate_event.errors[:event_name]).to include("is already in use by another event")
    end
  end

  context "custom date validations" do
    it "rejects early_bird_end_time in the past" do
      valid_event.early_bird_end_time = 1.day.ago
      expect(valid_event).not_to be_valid
      expect(valid_event.errors[:early_bird_end_time]).to include("can't be in the past")
    end

    it "rejects event_date in the past" do
      valid_event.event_date = 1.day.ago
      expect(valid_event).not_to be_valid
      expect(valid_event.errors[:event_date]).to include("can't be in the past")
    end

    it "rejects event_end_date before event_date" do
      valid_event.event_end_date = valid_event.event_date - 1.day
      expect(valid_event).not_to be_valid
      expect(valid_event.errors[:event_end_date]).to include("can't be before the event date")
    end

    it "rejects end_time before start_time" do
      valid_event.end_time = valid_event.start_time - 1.hour
      expect(valid_event).not_to be_valid
      expect(valid_event.errors[:end_time]).to include("can't be before the start time")
    end

    it "rejects event_date before start_time" do
      valid_event.event_date = valid_event.start_time - 1.day
      expect(valid_event).not_to be_valid
      expect(valid_event.errors[:event_date]).to include("can't be before the start time")
    end
  end

  
  context "associations" do
    it { should belong_to(:venue) }
    it { should belong_to(:event_type) }
    it { should belong_to(:user) }
    it { should have_many(:event_bookings).dependent(:destroy) }
    it { should have_many(:discount_code_transactions).dependent(:destroy) }
  end
end
