class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  enum state: [:incomplete, :placed, :processing, :ready, :delivered, :rejected]

  validates_presence_of :number
  after_initialize :generate_number

  PER_PAGE = 20

  def self.page_for_administrator(page)
    order('id desc').page(page).per(PER_PAGE)
  end

  def self.from_session(order_id)
    self.find_by id: order_id unless order_id.nil?
  end

  # Add item to order
  #
  # Increments value of quantity in OrderItem for this order.
  # @see OrderItem#add
  #
  # @param [Item] item
  # @param [Integer] quantity
  def add_item(item, quantity = 1)
    order_item = self.order_items.find_by item: item, price: item.price
    if order_item.is_a? OrderItem
      order_item.add quantity
    else
      self.order_items.create item: item, price: item.price, quantity: quantity
    end
    recalculate!
  end

  # Remove item from order
  #
  # Decrements value of quantity in OrderItem for this order
  # @see OrderItem#remove
  #
  # @param [Item] item
  def remove_item(item)
    order_item = self.order_items.where(item: item).order('price asc').first
    if order_item.is_a? OrderItem
      order_item.remove 1
      recalculate!
    end
  end

  private

  # Generate order number
  def generate_number
    if self.id.nil?
      last_part   = (Order.count + 1).to_s.rjust(3, '0')
      self.number = Time.now.strftime('%y%m%d') + last_part
    end
  end

  # Recalculate price and item count based on OrderItem data for this order
  def recalculate!
    attributes = { price: 0, item_count: 0 }
    self.order_items(true).map do |order_item|
      attributes[:price]      += order_item.price * order_item.quantity
      attributes[:item_count] += order_item.quantity
    end
    update attributes
  end
end
