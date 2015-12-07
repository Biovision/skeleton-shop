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

  describe '#add_item' do
    let!(:order) { create :order }
    let!(:item) { create :item, price: 42 }
    let(:action) { -> (quantity = 1) { order.add_item item, quantity } }

    shared_examples 'adding_new_row' do
      it 'creates new row in order_items' do
        expect(action).to change(OrderItem, :count).by(1)
      end

      it 'sets quantity to argument value' do
        action.call(2)
        expect(OrderItem.last.quantity).to eq(2)
      end

      it 'sets price to item price' do
        action.call
        expect(OrderItem.last.price).to eq(item.price)
      end
    end

    shared_examples 'incrementing_order_values' do
      it 'increments item_count for order' do
        expect(action).to change(order, :item_count).by(1)
      end

      it 'adds price to order' do
        expect(action).to change(order, :price).by(42)
      end
    end

    context 'when no items in order' do
      it_behaves_like 'adding_new_row'
      it_behaves_like 'incrementing_order_values'
    end

    context 'when the same item with the same price exists in order' do
      before(:each) do
        create :order_item, order: order, item: item, price: item.price, quantity: 1
        order.send :recalculate!
      end

      it_behaves_like 'incrementing_order_values'

      it 'does not create new row in order_items' do
        expect(action).not_to change(OrderItem, :count)
      end
    end

    context 'when the same item with different price exists in order' do
      before(:each) do
        create :order_item, order: order, item: item, price: 40, quantity: 3
        order.send :recalculate!
      end

      it_behaves_like 'adding_new_row'
      it_behaves_like 'incrementing_order_values'
    end
  end

  describe '#remove_item' do
    let!(:order) { create :order }
    let!(:item) { create :item, price: 16 }
    let(:action) { -> { order.remove_item item } }

    shared_examples 'decrementing_item_count' do
      it 'increments item_count for order' do
        expect(action).to change(order, :item_count).by(-1)
      end
    end

    context 'when several items with different prices exist' do
      before :each do
        @cheaper = create :order_item, order: order, item: item, price: 8, quantity: 2
        @current = create :order_item, order: order, item: item, price: item.price
        order.send :recalculate!
      end

      it_behaves_like 'decrementing_item_count'

      it 'decrements quantity for the lowest price' do
        action.call
        @cheaper.reload
        expect(@cheaper.quantity).to eq(1)
      end

      it 'decrements quantity for current price in the end' do
        action.call
        @current.reload
        expect(@current.quantity).to eq(1)
      end

      it 'decrements total price' do
        expect(action).to change(order, :price).by(-8)
      end
    end

    context 'when item price does not differ' do
      before :each do
        create :order_item, order: order, item: item, price: item.price
        order.send :recalculate!
      end

      it_behaves_like 'decrementing_item_count'

      it 'decrements total price' do
        expect(action).to change(order, :price).by(-item.price)
      end
    end
  end
end
