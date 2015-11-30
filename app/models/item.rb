class Item < ActiveRecord::Base
  include HasUniqueNameAndSlug

  belongs_to :brand, counter_cache: true
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories

  validates_numericality_of :price, greater_than: 0, allow_nil: true
end
