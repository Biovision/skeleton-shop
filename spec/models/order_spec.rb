require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'new instance' do
    it 'sets code as current date' do
      order = Order.new
      expect(order.number).to eq(Time.now.strftime('%y%m%d001').to_i)
    end

    it 'sets order count +1 as last number' do
      create :order
      order = Order.new
      expect(order.number).to eq(Time.now.strftime('%y%m%d002').to_i)
    end
  end

  describe 'validation' do
    it 'passes with valid attributes' do
      order = build :order
      expect(order).to be_valid
    end

    it 'fails without number' do
      order = build :order, number: nil
      expect(order).not_to be_valid
    end
  end
end
