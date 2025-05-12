class User < ApplicationRecord
  include JwtConcern
  has_secure_password

  # Associations
  has_many :event_bookings
  has_many :event_types
  has_many :events
  has_many :discount_codes
  belongs_to :role
  has_many :discount_code_transactions

  # Validations
  validates :first_name,
            :surname,
            :phone_no,
            :password,
            :email,
            presence: { message: "fields can't be blank" }

  validates :email,
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
              message: 'must be a valid email address'
            },
            uniqueness: { case_sensitive: false, message: 'is already in use by another user' }

  validates :phone_no,
            format: {
              with: /\A[0-9]{10}\z/,
              message: 'must be a valid 10-digit phone number without spaces or special characters'
            },
            uniqueness: { message: 'is already in use by another user' }

  validates :password,
            length: { minimum: 6, message: 'must be at least 6 characters long' }

  # Role-based methods
  def is_admin?
    role_id == 1
  end

  def is_user?
    role_id == 2
  end

  def is_organizer?
    role_id == 3
  end
end
