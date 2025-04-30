class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :organizer_name
      t.string :event_name
      t.string :description
      t.datetime :event_date
      t.datetime :event_end_date
      t.datetime :start_time
      t.datetime :end_time
      t.integer :capacity
      t.integer :registered_count, default: 0
      t.integer :base_price
      t.integer :early_bird_price
      t.datetime :early_bird_end_time
      t.string :status, default: 'upcoming'
      t.references :user, foreign_key: true
      t.references :venue, foreign_key: true
      t.references :event_type,foreign_key: true

      t.timestamps
    end
  end
end
