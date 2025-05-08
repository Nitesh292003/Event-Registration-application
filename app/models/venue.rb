class Venue < ApplicationRecord
    #belongs_to :user
    has_many :events
    validates :venue_name, presence: true, length: { maximum: 100 }
    validates :address, presence: true
    validates :state, presence: true
    validates :country, presence: true
    validates :postal_code, presence: true, format: { with: /\A[0-9]{5}(-[0-9]{4})?\z/, message: "should be in the format 12345 or 12345-6789" }
  end
  