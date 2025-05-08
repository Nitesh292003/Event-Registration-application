class CreateVenues < ActiveRecord::Migration[8.0]
  def change
    create_table :venues do |t|
      t.string :venue_name
      t.string :address
      t.string :state
      t.string :country
      t.string :postal_code

      t.timestamps
    end
  end
end
