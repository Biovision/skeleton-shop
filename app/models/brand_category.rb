class BrandCategory < ActiveRecord::Base
  include RequiresCategory

  belongs_to :brand
  validates_presence_of :brand_id
  validates_uniqueness_of :brand_id, scope: [:category_id]

  after_create :increment_brand_count
  after_destroy :decrement_brand_count

  private

  def increment_brand_count
    self.category.increment! :brand_count
  end

  def decrement_brand_count
    self.category.decrement! :brand_count
  end
end
