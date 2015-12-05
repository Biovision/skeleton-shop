require 'rails_helper'

RSpec.describe Order, type: :model, focus: true do
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
    shared_examples 'adding_new_row' do
      it 'creates new row in order_items'
    end

    shared_examples 'incrementing_order_values' do
      it 'increments item_count for order'
      it 'adds price to order'

    end

    context 'when no items in order' do
      it_behaves_like 'adding_new_row'
      it_behaves_like 'incrementing_order_values'
    end

    context 'when the same item with the same price exists in order' do
      it_behaves_like 'incrementing_order_values'

      it 'increments quantity'
    end

    context 'when the same item with different price exists in order' do
      it_behaves_like 'adding_new_row'
      it_behaves_like 'incrementing_order_values'
    end
  end

  describe '#remove_item' do
    context 'when several items with different prices exist' do
      it 'decrements'
    end
  end
end
