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

  scope :visible, -> (visible = true) { where visible: true unless visible.nil? }
  scope :ordered_by_priority, -> { order 'priority asc' }

  PER_PAGE = 25

  # @param [Integer] page
  def self.page_for_administrator(page)
    ordered_by_name.page(page).per(PER_PAGE)
  end

  def self.level(parent_id, visible = nil)
    where(parent_id: parent_id).visible(visible).ordered_by_priority
  end

  # @return [Array]
  def self.entity_parameters
    [:parent_id, :visible, :priority, :name, :slug, :image, :description]
  end

  def has_item?(item)
    self.items.include? item
  end
end
