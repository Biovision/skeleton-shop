class Category < ActiveRecord::Base
  include HasUniqueNameAndSlug

  has_many :brand_categories, dependent: :destroy
  has_many :item_categories, dependent: :destroy
  has_many :brands, through: :brand_categories
  has_many :items, through: :item_categories

  validates_numericality_of :priority, greater_than: 0

  PER_PAGE = 25

  # @param [Integer] page
  def self.page_for_administrator(page)
    ordered_by_name.page(page).per(PER_PAGE)
  end

  # @return [Array]
  def self.entity_parameters
    [:name, :slug, :image, :description]
  end
end
