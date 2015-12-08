class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.timestamps null: false
      t.integer :number, null: false
      t.integer :price, null: false, default: 0
      t.integer :item_count, null: false, default: 0
      t.integer :state, null: false, default: Order.states[:incomplete]
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.text :comment
    end
  end
end
