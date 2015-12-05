require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it_behaves_like 'has_mandatory_item'

  describe 'validation' do
    it 'passes with valid attributes' do
      order_item = build :order_item
      expect(order_item).to be_valid
    end

    it 'fails without order' do
      order_item = build :order_item, order_id: nil
      expect(order_item).not_to be_valid
    end
  end

  describe '#add' do
    it 'increments quantity' do
      order_item = create :order_item
      expect { order_item.add 2 }.to change(order_item, :quantity).by(2)
    end
  end

  describe '#remove' do
    it 'decrements quantity' do
      order_item = create :order_item, quantity: 6
      expect { order_item.remove 2 }.to change(order_item, :quantity).by(-2)
    end

    it 'removes row when quantity becomes 0 or less' do
      order_item = create :order_item
      expect { order_item.remove 10 }.to change(OrderItem, :count).by(-1)
    end
  end
end
