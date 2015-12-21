class Category < ActiveRecord::Base
  include HasUniqueNameAndSlug

  belongs_to :parent, class_name: Category.to_s
  has_many :categories, foreign_key: :parent_id, dependent: :nullify
  has_many :brand_categories, dependent: :destroy
  has_many :item_categories, dependent: :destroy
  has_many :brands, through: :brand_categories
  has_many :items, through: :item_categories

  mount_uploader :image, ImageUploader

  validates_numericality_of :priority, greater_than: 0

  PER_PAGE = 25

  # @param [Integer] page
  def self.page_for_administrator(page)
    ordered_by_name.page(page).per(PER_PAGE)
  end

  # @return [Array]
  def self.entity_parameters
    [:parent_id, :visible, :priority, :name, :slug, :image, :description]
  end
end
