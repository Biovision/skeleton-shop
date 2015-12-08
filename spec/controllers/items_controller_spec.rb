require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:user) { create :administrator }
  let!(:entity) { create :item }

  before :each do
    allow(controller).to receive(:require_role)
    allow(controller).to receive(:current_user).and_return(user)
  end

  shared_examples 'entity_assigner' do
    it 'assigns item to @entity' do
      expect(assigns[:entity]).to eq(entity)
    end
  end

  describe 'get index' do
    before(:each) { get :index }

    it_behaves_like 'page_for_administrator'

    it 'assigns list of items to @collection' do
      expect(assigns[:collection]).to include(entity)
    end
  end

  describe 'get new' do
    before(:each) { get :new }

    it_behaves_like 'page_for_administrator'

    it 'assigns new instance Item to @entity' do
      expect(assigns[:entity]).to be_a_new(Item)
    end

    it 'renders view "new"' do
      expect(response).to render_template(:new)
    end
  end

  describe 'post create' do
    let(:category) { create :category }
    let(:action) { -> { post :create, item: attributes_for(:item), category_ids: [category.id.to_s] } }

    context 'authorization and redirects' do
      before(:each) do
        allow_any_instance_of(Item).to receive(:category_ids=)
        action.call
      end

      it_behaves_like 'page_for_administrator'

      it 'redirects to created item' do
        expect(response).to redirect_to(Item.last)
      end
    end

    context 'database change' do
      it 'inserts row into items table' do
        expect(action).to change(Item, :count).by(1)
      end

      it 'sets category ids for new item' do
        expect_any_instance_of(Item).to receive(:category_ids=).with([category.id.to_s])
        action.call
      end
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

    before(:each) do
      allow(controller).to receive(:set_categories)
      patch :update, id: entity, item: { name: 'new value' }, category_ids: [category.id.to_s]
    end

    it_behaves_like 'page_for_administrator'
    it_behaves_like 'entity_assigner'

    it 'updates item' do
      entity.reload
      expect(entity.name).to eq('new value')
    end

    it 'redirects to item page' do
      expect(response).to redirect_to(entity)
    end

    it 'sets categories' do
      expect(controller).to have_received(:set_categories)
    end
  end

  describe 'delete destroy' do
    let(:action) { -> { delete :destroy, id: entity } }

    context 'authorization' do
      before(:each) { action.call }

      it_behaves_like 'page_for_administrator'

      it 'redirects to items page' do
        expect(response).to redirect_to(items_path)
      end
    end

    it 'removes item from database' do
      expect(action).to change(Item, :count).by(-1)
    end
  end
end
