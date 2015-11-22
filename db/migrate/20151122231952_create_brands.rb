class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.timestamps null: false
      t.integer :item_count, limit: 2, null: false, default: 0
      t.string :name, null: false
      t.string :slug, null: false
      t.string :image
      t.text :description
    end
  end
end
