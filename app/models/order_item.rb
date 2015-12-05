class OrderItem < ActiveRecord::Base
  include RequiresItem

  belongs_to :order
  validates_presence_of :order_id

  def add(quantity = 1)
    increment! :quantity, quantity
  end

  def remove(quantity = 1)
    decrement! :quantity, quantity
    destroy if self.quantity < 1
  end
end
