class Category < ActiveRecord::Base
  include HasUniqueNameAndSlug

  has_many :brand_categories, dependent: :destroy
  has_many :item_categories, dependent: :destroy
  has_many :brands, through: :brand_categories
  has_many :items, through: :item_categories

  validates_numericality_of :priority, greater_than: 0
end
