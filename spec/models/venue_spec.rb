require 'rails_helper'

RSpec.describe Venue, type: :model do
  subject { build(:venue) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a venue_name' do
      subject.venue_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:venue_name]).to include("can't be blank")
    end

    it 'is not valid if venue_name is longer than 100 characters' do
      subject.venue_name = 'a' * 101
      expect(subject).to_not be_valid
    end

    it 'is not valid without an address' do
      subject.address = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a state' do
      subject.state = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a country' do
      subject.country = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a postal_code' do
      subject.postal_code = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with an incorrectly formatted postal_code' do
      subject.postal_code = 'ABCDE'
      expect(subject).to_not be_valid
    end

    it 'is valid with postal_code in the format 12345-6789' do
      subject.postal_code = '12345-6789'
      expect(subject).to be_valid
    end
  end
end
