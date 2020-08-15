class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.total_amount null: false
      t.total_items null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
