# frozen_string_literal: true

class AddColumn < ActiveRecord::Migration[8.0]
  def change
    add_column :event_bookings, :total_price, :decimal, precision: 10, scale: 2
  end
end
