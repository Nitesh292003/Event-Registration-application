require 'rails_helper'

RSpec.describe DiscountCode, type: :model do
  subject { build(:discount_code) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without a code' do
      subject.code = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:code]).to include("can't be blank")
    end

    it 'is invalid if the code is not exactly 9 alphanumeric characters' do
      subject.code = 'abc123'  
      expect(subject).to_not be_valid
      expect(subject.errors[:code]).to include('must be exactly 9 characters using only letters and numbers')

      subject.code = 'INVALID_CODE' 
      expect(subject).to_not be_valid
    end

    it 'is invalid with a duplicate code' do
      create(:discount_code, code: 'ABC123XYZ')
      duplicate = build(:discount_code, code: 'ABC123XYZ')
      expect(duplicate).to_not be_valid
      expect(duplicate.errors[:code]).to include('discount code already in use')
    end

    it 'is invalid without a discount_percentage' do
      subject.discount_percentage = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid if discount_percentage is not between 1 and 100' do
      subject.discount_percentage = 0
      expect(subject).to_not be_valid

      subject.discount_percentage = 101
      expect(subject).to_not be_valid
    end

    it 'is invalid without a start_date' do
      subject.start_date = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid without an end_date' do
      subject.end_date = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid if end_date is before or equal to start_date' do
      subject.start_date = 3.days.from_now
      subject.end_date = 2.days.from_now
      expect(subject).to_not be_valid
      expect(subject.errors[:end_date]).to include("can't be before the start date")
    end

    it 'is invalid without max_uses' do
      subject.max_uses = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid if max_uses is not a positive integer' do
      subject.max_uses = 0
      expect(subject).to_not be_valid

      subject.max_uses = -5
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end
end
