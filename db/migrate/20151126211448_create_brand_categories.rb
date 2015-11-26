class CreateBrandCategories < ActiveRecord::Migration
  def change
    create_table :brand_categories do |t|
      t.references :brand, index: true, foreign_key: true, null: false
      t.references :category, index: true, foreign_key: true, null: false
    end
  end
end
