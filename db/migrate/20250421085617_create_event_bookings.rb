# frozen_string_literal: true

class CreateEventBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :event_bookings do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.references :event_type, foreign_key: true
      t.references :discount_code, foreign_key: true
      t.string :status, default: 'pending'
      t.integer :ticket_count
      t.integer :total_price
      t.timestamps
    end
  end
end
