class ItemCategory < ActiveRecord::Base
  include RequiresCategory
  include RequiresItem

  validates_uniqueness_of :item_id, scope: [:category_id]

  after_create :increment_item_count
  after_destroy :decrement_item_count

  private

  def increment_item_count
    self.category.increment! :item_count
  end

  def decrement_item_count
    self.category.decrement! :item_count
  end
end
