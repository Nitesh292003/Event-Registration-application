# frozen_string_literal: true

class ChangesInEventBooking < ActiveRecord::Migration[8.0]
  def change
    drop_table :event_bookings
  end
end
