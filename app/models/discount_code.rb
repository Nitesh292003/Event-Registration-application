class DiscountCode < ApplicationRecord
    belongs_to :user
    belongs_to :event
    has_many :discount_code_transactions
    has_many :event_bookings

    validates :code, presence: true, uniqueness: { message: "discount code already in use" }
    validates :discount_percentage, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100, message: "must be between 0 and 100" }
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :max_uses, presence: true, numericality: { only_integer: true, greater_than: 0, message: "must be a positive integer" }
   
    validate :end_date_cannot_be_before_start_date
    validate :max_uses_must_be_positive_integer
  
     
    validates :code, presence: true, uniqueness: true,
    format: { with: /\A[a-zA-Z0-9]{9}\z/, message: "must be exactly 9 characters using only letters and numbers" }


   

    def end_date_cannot_be_before_start_date
        if end_date.present? && end_date <= start_date
            errors.add(:end_date, "can't be before the start date")
        end
    end
    def max_uses_must_be_positive_integer
        if max_uses.present? && max_uses <= 0
            errors.add(:max_uses, "must be a positive integer")
        end
    end
   
end
