# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :event_booking, null: false, foreign_key: true
      t.decimal :total_amount, precision: 10, scale: 2
      t.string :payment_status
      t.datetime :payment_date

      t.timestamps
    end
  end
end
