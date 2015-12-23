class Item < ActiveRecord::Base
  include HasUniqueNameAndSlug

  belongs_to :brand, counter_cache: true
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  mount_uploader :image, ImageUploader

  validates_numericality_of :price, greater_than: 0, allow_nil: true

  PER_PAGE = 25
  PER_PAGE_SHOP = 12

  scope :visible, -> (visible = true) { where visible: true unless visible.nil? }
  scope :with_price, -> { where 'price > 0' }

  def self.page_for_administrator(page)
    ordered_by_name.page(page).per(PER_PAGE)
  end

  def self.page_for_shop(page)
    visible.with_price.ordered_by_name.page(page).per(PER_PAGE_SHOP)
  end

  def self.entity_parameters
    [:brand_id, :price, :visible, :name, :slug, :image, :description]
  end

  # @param [Array] category_ids
  def category_ids=(category_ids)
    self.categories = Category.where id: category_ids
  end
end
