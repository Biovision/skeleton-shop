class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.timestamps null: false
      t.integer :priority, limit: 2, null: false, default: 1
      t.boolean :visible, null: false, default: true
      t.integer :brand_count, limit: 2, null: false, default: 0
      t.integer :item_count, limit: 2, null: false, default: 0
      t.string :name, null: false
      t.string :slug, null: false
      t.string :image
      t.text :description
    end

    add_index :categories, :slug, unique: true
  end
end
