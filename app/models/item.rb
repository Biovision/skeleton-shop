class Item < ActiveRecord::Base
  include HasUniqueNameAndSlug

  belongs_to :brand, counter_cache: true
  validates_numericality_of :price, greater_than: 0, allow_nil: true
end
