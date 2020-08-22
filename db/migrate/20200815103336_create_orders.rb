class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.decimal :total_amount, null: false
      t.integer :total_items, null: false
      t.string :billing_address, null: false
      t.boolean :processed, default: false, null: false
      t.string :delivery_date
      t.references :user, null: false
      t.timestamps
    end
  end
end
