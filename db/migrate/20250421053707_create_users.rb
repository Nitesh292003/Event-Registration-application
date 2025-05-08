class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :surname
      t.string :email
      t.string :phone_no
      t.string :password
      t.references :role, foreign_key: true
      t.timestamps
    end
  end
end
