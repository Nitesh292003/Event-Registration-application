class Event < ApplicationRecord
    belongs_to :venue
    belongs_to :event_type

    has_many:discount_code, dependent: :destroy
    has_many :event_bookings, dependent: :destroy
    has_many :discount_code_transactions, dependent: :destroy

    validates :organizer_name, :event_name, :description,
              :event_date, :event_end_date, :start_time, :end_time,
              :capacity, :base_price,
              presence: { message: "field can't be blank" }

    validates :event_name, uniqueness: { message: "is already in use by another event" }
    validates :base_price, numericality: { greater_than: 0, message: "amount should be greater than 0" }
    validates :capacity, numericality: { greater_than_or_equal_to: 30, message: "should be at least 30" }
    validates :early_bird_price, numericality: { greater_than: 0, message: "amount should be greater than 0" }

    # validate :early_bird_end_time_cannot_be_in_the_past
    # validate :event_date_cannot_be_in_the_past
    # validate :event_end_date_cannot_be_before_event_date
    # validate :start_time_cannot_be_in_the_past
    # validate :end_time_cannot_be_before_start_time
    # validate :event_date_cannot_be_before_start_time

    
    validate :event_time_does_not_overlap, on: :create
    validate :event_time_does_not_overlap, on: :update
   

  
    

    # def early_bird_end_time_cannot_be_in_the_past
    #     if early_bird_end_time.present? && early_bird_end_time < Time.current
    #         errors.add(:early_bird_end_time, "can't be in the past")
    #     end
    # end

    # def event_date_cannot_be_in_the_past
    #     if event_date.present? && event_date < Time.current
    #         errors.add(:event_date, "can't be in the past")
    #     end
    # end

    # def event_end_date_cannot_be_before_event_date
    #     if event_end_date.present? && event_end_date <= event_date
    #         errors.add(:event_end_date, "can't be before the event date")
    #     end
    # end

    # def start_time_cannot_be_in_the_past
    #     if start_time.present? && start_time < Time.current
    #         errors.add(:start_time, "can't be in the past")
    #     end
    # end

    # def end_time_cannot_be_before_start_time
    #     if end_time.present? && end_time < start_time
    #         errors.add(:end_time, "can't be before the start time")
    #     end
    # end

    # def event_date_cannot_be_before_start_time
    #     if event_date.present? && event_date < start_time
    #         errors.add(:event_date, "can't be before the start time")
    #     end
    # end

    private

    def event_time_does_not_overlap
     
      overlapping_events = Event.where(venue_id: venue_id).where.not(id: id)
  
     
      overlapping_events.each do |event|
        if time_overlap?(event)
          errors.add(:base, "Event time overlaps with another event")
          break 
        end
      end
    end
  
    def time_overlap?(event)
      start_datetime = DateTime.new(event_date.year, event_date.month, event_date.day, start_time.hour, start_time.min)
      end_datetime = DateTime.new(event_end_date.year, event_end_date.month, event_end_date.day, end_time.hour, end_time.min)
  
      existing_event_start_datetime = DateTime.new(event.event_date.year, event.event_date.month, event.event_date.day, event.start_time.hour, event.start_time.min)
      existing_event_end_datetime = DateTime.new(event.event_end_date.year, event.event_end_date.month, event.event_end_date.day, event.end_time.hour, event.end_time.min)
  
      start_datetime < existing_event_end_datetime && end_datetime > existing_event_start_datetime
    end
end