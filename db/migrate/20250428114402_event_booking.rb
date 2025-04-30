class EventBooking < ActiveRecord::Migration[8.0]
  def change
    create_table :event_bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :number_of_tickets, null: false
      t.string :status, default: "pending"
      t.datetime :booking_date

      t.timestamps
    end

    add_index :event_bookings, [:user_id, :event_id], unique: true
  end
end
