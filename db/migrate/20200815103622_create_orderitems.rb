class CreateOrderitems < ActiveRecord::Migration[6.0]
  def change
    create_table :orderitems do |t|
      t.decimal :quantity, precision: 10, scale: 2
      t.references :item, null: false
      t.references :order, null: false
      t.timestamps
    end
  end
end
