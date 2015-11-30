class Brand < ActiveRecord::Base
  include HasUniqueNameAndSlug

  has_many :items, dependent: :nullify
  has_many :brand_categories, dependent: :destroy
  has_many :categories, through: :brand_categories
end
