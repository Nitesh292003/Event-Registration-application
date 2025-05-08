require 'rails_helper'

RSpec.describe User, type: :model do
  it "is a valid user with valid attributes" do
    user = create(:user)
    puts user.inspect
    expect(user).to be_valid
  end

  it "is invalid without a first name" do
    user = build(:user, first_name: nil)
    expect(user).not_to be_valid
    expect(user.errors[:first_name]).to include("fields can't be blank")
  end
  
  it "is invalid without a surname" do
    user = build(:user, surname: nil)
    expect(user).not_to be_valid
    expect(user.errors[:surname]).to include("fields can't be blank")
  end
  

  it { should belong_to(:role) }
  it { should have_many(:event_bookings) }
  it { should have_many(:events) }
  it { should have_many(:discount_codes) }
  it { should have_many(:discount_code_transactions) }

  
  context "validations for email" do
    it "should not be duplicate" do
      create(:user, email: "nitesh112@gmail.com")
      duplicate_email_user = build(:user, email: "nitesh112@gmail.com")
      expect(duplicate_email_user).not_to be_valid
      expect(duplicate_email_user.errors[:email]).to include("is already in use by another user")
    end

    it "should not be null" do
      user_email = build(:user, email: nil)
      expect(user_email).not_to be_valid
      expect(user_email.errors[:email]).to include("fields can't be blank")
    end

    it "should have a valid email address" do
      user_email = build(:user, email: "@nitesh12gmail")
      expect(user_email).not_to be_valid
      expect(user_email.errors[:email]).to include("must be a valid email address")
    end
  end

  context "validations for password" do
    it "should not be null" do
      user_password = build(:user, password: nil)
      expect(user_password).not_to be_valid
      expect(user_password.errors[:password]).to include("fields can't be blank")
    end

    it "should have a proper length" do
      user_password = build(:user, password: "123a")
      expect(user_password).not_to be_valid
      expect(user_password.errors[:password]).to include("must be at least 6 characters long")
    end
  end

  context "validation for phone number" do
    it "should not be null" do
      user_phone_no = build(:user, phone_no: nil)
      expect(user_phone_no).not_to be_valid
      expect(user_phone_no.errors[:phone_no]).to include("fields can't be blank")
    end

    it "should not be duplicate" do
      create(:user, phone_no: "7800562273")
      user_phone_no = build(:user, phone_no: "7800562273")
      expect(user_phone_no).not_to be_valid
      expect(user_phone_no.errors[:phone_no]).to include("is already in use by another user")
    end

    it "should be a valid phone number" do
      user_phone_no = build(:user, phone_no: "87534abc!")
      expect(user_phone_no).not_to be_valid
      expect(user_phone_no.errors[:phone_no]).to include("must be a valid 10-digit phone number without spaces or special characters")
    end
  end

    describe "#is_admin?" do
      it "returns true if role_id is 1" do
        user=build(:user, role_id: 1)
        expect(user.is_admin?).to be true
      end

      it "returns false if role_id is not 1" do
        user=build(:user, role_id: 2)
        expect(user.is_admin?).to be false
      end

      it "returns false if role_id is not 1" do
        user=build(:user, role_id: 3)
        expect(user.is_admin?).to be false
      end
    end

    describe "#is_user?" do
      it "returns true if role_id is 2" do
        user=build(:user, role_id: 2)
        expect(user.is_user?).to be true
      end

      it "returns false if role_id is not 2" do
        user=build(:user, role_id: 1)
        expect(user.is_user?).to be false
      end

      it "returns false if role_id is not 1" do
        user=build(:user, role_id: 3)
        expect(user.is_user?).to be false
      end
    end

    describe "#is_organizer?" do
      it "returns true if role_id is 3" do
        user=build(:user, role_id: 3)
        expect(user.is_organizer?).to be true
      end

      it "returns false if role_id is not 3" do
        user=build(:user, role_id: 1)
        expect(user.is_organizer?).to be false
      end

      it "returns false if role_id is not 3" do
        user=build(:user, role_id: 2)
        expect(user.is_organizer?).to be false
      end
    end

end
