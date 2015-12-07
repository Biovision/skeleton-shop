class Brand < ActiveRecord::Base
  include HasUniqueNameAndSlug

  has_many :items, dependent: :nullify
  has_many :brand_categories, dependent: :destroy
  has_many :categories, through: :brand_categories

  PER_PAGE = 25

  def self.page_for_administrator(page)
    ordered_by_name.page(page).per(PER_PAGE)
  end

  def self.entity_parameters
    [:name, :slug, :image, :description]
  end
end
