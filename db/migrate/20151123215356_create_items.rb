class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.timestamps null: false
      t.references :brand, index: true, foreign_key: true
      t.integer :price
      t.string :name, null: false
      t.string :slug, null: false
      t.string :image
      t.text :description
    end

    add_index :items, :slug, unique: true
  end
end
