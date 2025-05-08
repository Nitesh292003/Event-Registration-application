class EventBooking < ApplicationRecord
    belongs_to :user
    belongs_to :event
    has_many :payments
    has_one_attached :id_proof
  
    before_validation :set_defaults
    validate :check_event_capacity, on: :create
  
    private
  
    def set_defaults
      self.booking_date ||= Time.current
      self.status ||= 'pending'
    end
  
    def check_event_capacity
      event = self.event
  
      if event.registered_count >= event.capacity
        errors.add(:base, "Seats are fully booked for this event.")
      elsif self.number_of_tickets + event.registered_count > event.capacity
        errors.add(:base, "Only #{event.capacity - event.registered_count} seats left for this event.")
      end
    end
  end
  