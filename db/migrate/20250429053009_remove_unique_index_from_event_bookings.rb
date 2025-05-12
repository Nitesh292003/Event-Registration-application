# frozen_string_literal: true

class RemoveUniqueIndexFromEventBookings < ActiveRecord::Migration[8.0]
  def change
    remove_index :event_bookings, name: 'index_event_bookings_on_user_id_and_event_id'
  end
end
