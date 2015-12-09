require 'rails_helper'

RSpec.describe Shop::ItemsController, type: :controller do
  let!(:item) { create :item_with_price }

  shared_examples 'redirect_to_item' do
    it 'redirects to item page' do
      action.call
      expect(response).to redirect_to(item)
    end
  end

  shared_examples 'adding_item' do
    it 'calls order#add_item' do
      expect_any_instance_of(Order).to receive(:add_item).with(item, 3)
      action.call
    end
  end

  shared_examples 'removing_item' do
    it 'calls order#remove_item' do
      expect_any_instance_of(Order).to receive(:remove_item).with(item)
      action.call
    end
  end

  context 'when order_id is not set in session' do
    before(:each) { session[:order_id] = nil }

    shared_examples 'creating_new_order' do
      it 'creates new order' do
        expect(action).to change(Order, :count).by(1)
      end
    end

    describe 'post create' do
      let(:action) { -> { post :create, id: item.id, quantity: 3 } }

      it_behaves_like 'creating_new_order'
      it_behaves_like 'adding_item'
      it_behaves_like 'redirect_to_item'
    end

    describe 'delete destroy' do
      let(:action) { -> { delete :destroy, id: item.id } }

      it_behaves_like 'creating_new_order'
      it_behaves_like 'removing_item'
      it_behaves_like 'redirect_to_item'
    end
  end

  context 'when order_id is set in session' do
    let(:order) { create :order }
    before(:each) { session[:order_id] = order.id }

    shared_examples 'not_creating_order' do
      it 'does not create new order' do
        expect(action).not_to change(Order, :count)
      end
    end

    describe 'post create' do
      let(:action) { -> { post :create, id: item.id, quantity: 3 } }

      it_behaves_like 'not_creating_order'
      it_behaves_like 'adding_item'
      it_behaves_like 'redirect_to_item'
    end

    describe 'delete destroy' do
      let(:action) { -> { delete :destroy, id: item.id } }

      it_behaves_like 'not_creating_order'
      it_behaves_like 'removing_item'
      it_behaves_like 'redirect_to_item'
    end
  end
end
