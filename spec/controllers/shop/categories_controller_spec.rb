require 'rails_helper'

RSpec.describe Shop::CategoriesController, type: :controller do
  let!(:category) { create :category }

  describe 'get index' do
    let!(:hidden_category) { create :category, visible: false }
    let!(:child_category) { create :category, parent_id: category.id }

    before(:each) { get :index }

    it 'adds visible root categories to @categories' do
      expect(assigns[:categories]).to include(category)
    end

    it 'does not add non-root categories to @categories' do
      expect(assigns[:categories]).not_to include(child_category)
    end

    it 'does not add invisible root categories to @categories' do
      expect(assigns[:categories]).not_to include(hidden_category)
    end
  end

  describe 'get show' do
    before(:each) { get :show, id: category.slug }

    it 'assigns category to @category' do
      expect(assigns[:category]).to eq(category)
    end
  end
end
