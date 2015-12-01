class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.timestamps null: false
      t.references :order, index: true, foreign_key: true, null: false
      t.references :item, index: true, foreign_key: true, null: false
      t.integer :quantity, limit: 2, null: false
      t.integer :price, null: false
    end
  end
end
