require 'rails_helper'

RSpec.describe Shop::CartsController, type: :controller, focus: true do
  context 'when session[:order_id] is not set' do
    before(:each) { session[:order_id] = nil }

    shared_examples 'creating_new_order' do
      it 'creates new order in database' do
        expect(action).to change(Order, :count).by(1)
      end

      it 'stores order id in session' do
        action.call
        expect(session[:order_id]).to eq(Order.last.id)
      end
    end

    describe 'get show' do
      let(:action) { -> { get :show } }

      it_behaves_like 'creating_new_order'
    end

    describe 'get edit' do
      let(:action) { -> { get :edit } }

      it_behaves_like 'creating_new_order'
    end

    describe 'patch update' do
      let(:action) { -> { patch :update } }

      it_behaves_like 'creating_new_order'

      it 'redirects to cart'
    end

    describe 'delete destroy' do
      let(:action) { -> { delete :destroy } }

      it 'does not add new order' do
        expect(action).not_to change(Order, :count)
      end

      it 'does not set order_id in session' do
        action.call
        expect(session[:order_id]).to be_nil
      end

      it 'redirects to root' do
        action.call
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context 'when session[:order_id] is set' do
    let!(:order) { create :order }

    before(:each) { session[:order_id] = order.id }

    shared_examples 'order_assigner' do
      it 'assigns order to @order' do
        expect(assigns[:order]).to eq(order)
      end
    end

    describe 'get show' do
      before(:each) { get :show }

      it_behaves_like 'order_assigner'
    end

    describe 'get edit' do
      before(:each) { get :edit }

      it_behaves_like 'order_assigner'
    end

    describe 'patch update' do
      before(:each) { patch :update, order: { name: 'Client', phone: '000-00-00', email: 'client@example.com' } }

      it_behaves_like 'order_assigner'

      it 'updates order parameters'
      it 'changes order status'
      it 'removes order_id from session'
      it 'redirects to root'
    end

    describe 'delete destroy' do
      before(:each) { delete :destroy }

      it_behaves_like 'order_assigner'

      it 'changes order state to :rejected' do
        order.reload
        expect(order).to be_rejected
      end

      it 'removes order_id from session' do
        expect(session[:order_id]).to be_nil
      end

      it 'redirects to root' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
