class Order < ActiveRecord::Base
  enum state: [:placed, :processing, :ready, :delivered, :rejected]

  validates_presence_of :number
  after_initialize :generate_number

  private

  def generate_number
    if self.id.nil?
      last_part   = (Order.count + 1).to_s.rjust(3, '0')
      self.number = Time.now.strftime('%y%m%d') + last_part
    end
  end
end
