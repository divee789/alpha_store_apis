class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.decimal :total_amount, null: false
      t.integer :total_items, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
