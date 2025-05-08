class CreateDiscountCodeTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :discount_code_transactions do |t|
      t.references :user, foreign_key: true
      t.references :discount_code, foreign_key: true
      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end
