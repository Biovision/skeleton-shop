class Item < ActiveRecord::Base
  include HasUniqueNameAndSlug

  belongs_to :brand, counter_cache: true
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  validates_numericality_of :price, greater_than: 0, allow_nil: true
end
