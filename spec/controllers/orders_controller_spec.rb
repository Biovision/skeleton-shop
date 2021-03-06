require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create :administrator }
  let!(:entity) { create :order }

  before :each do
    allow(controller).to receive(:require_role)
    allow(controller).to receive(:current_user).and_return(user)
  end

  shared_examples 'entity_assigner' do
    it 'assigns order to @entity' do
      expect(assigns[:entity]).to eq(entity)
    end
  end

  describe 'get index' do
    before(:each) { get :index }

    it_behaves_like 'page_for_administrator'

    it 'assigns list of orders to @collection' do
      expect(assigns[:collection]).to include(entity)
    end
  end

  describe 'get show' do
    before(:each) { get :show, id: entity }

    it_behaves_like 'page_for_administrator'
    it_behaves_like 'entity_assigner'

    it 'renders view "show"' do
      expect(response).to render_template(:show)
    end
  end

  describe 'get edit' do
    before(:each) { get :edit, id: entity }

    it_behaves_like 'page_for_administrator'
    it_behaves_like 'entity_assigner'

    it 'renders view "edit"' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'patch update' do
    let(:category) { create :category }

    before :each do
      patch :update, id: entity, order: { state: 'processing' }
    end

    it_behaves_like 'page_for_administrator'
    it_behaves_like 'entity_assigner'

    it 'updates order' do
      entity.reload
      expect(entity).to be_processing
    end

    it 'redirects to order page' do
      expect(response).to redirect_to(entity)
    end
  end

  describe 'delete destroy' do
    let(:action) { -> { delete :destroy, id: entity } }

    context 'authorization and redirect' do
      before(:each) { action.call }

      it_behaves_like 'page_for_administrator'

      it 'redirects to orders page' do
        expect(response).to redirect_to(orders_path)
      end
    end

    it 'removes order from database' do
      expect(action).to change(Order, :count).by(-1)
    end
  end
end
