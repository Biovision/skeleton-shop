class OrderItem < ActiveRecord::Base
  include RequiresItem

  belongs_to :order
  validates_presence_of :order_id

  # Increment quantity
  #
  # @param [Integer] quantity
  def add(quantity = 1)
    increment! :quantity, quantity
  end

  # Decrement quantity
  #
  # Removes link if quantity becomes less than 1
  #
  # @param [Integer] quantity
  def remove(quantity = 1)
    decrement! :quantity, quantity
    destroy if self.quantity < 1
  end
end
