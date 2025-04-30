class CreateDiscountCodes < ActiveRecord::Migration[8.0]
  def change
    create_table :discount_codes do |t|
      t.string :code
      t.integer :discount_percentage
      t.datetime :start_date
      t.datetime :end_date
      t.integer :max_uses
      t.integer :used_count, default: 0
     
      t.string :status, default: "active"
 
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true


      t.timestamps
    end
  end
end
