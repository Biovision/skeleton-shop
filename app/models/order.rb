class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  enum state: [:placed, :processing, :ready, :delivered, :rejected]

  validates_presence_of :number
  after_initialize :generate_number

  def add_item(item, quantity = 1)
    order_item = self.order_items.find_by item: item, price: item.price
    if order_item.is_a? OrderItem
      order_item.add quantity
    else
      self.order_items.create item: item, price: item.price, quantity: quantity
    end
    recalculate!
  end

  private

  def generate_number
    if self.id.nil?
      last_part   = (Order.count + 1).to_s.rjust(3, '0')
      self.number = Time.now.strftime('%y%m%d') + last_part
    end
  end

  def recalculate!
    attributes = { price: 0, item_count: 0 }
    self.order_items.map do |order_item|
      attributes[:price] += order_item.price * order_item.quantity
      attributes[:item_count] += order_item.quantity
    end
    update attributes
  end
end
