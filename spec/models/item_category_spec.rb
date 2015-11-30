require 'rails_helper'

RSpec.describe ItemCategory, type: :model do
  it_behaves_like 'has_mandatory_category'
  it_behaves_like 'has_mandatory_item'

  describe 'validation' do
    it 'passes with valid attributes' do
      item_category = build :item_category
      expect(item_category).to be_valid
    end

    it 'fails with non-unique pair' do
      existing = create :item_category
      item_category = build :item_category, item_id: existing.item_id, category_id: existing.category_id
      expect(item_category).not_to be_valid
    end
  end

  describe 'after creation' do
    let!(:category) { create :category }

    it 'increases item_count in category' do
      action = -> { create :item_category, category: category }
      expect(action).to change(category, :item_count).by(1)
    end
  end

  describe 'after destruction' do
    it 'decreases item_count in category' do
      item_category = create :item_category
      action = -> { item_category.destroy }
      expect(action).to change(item_category.category, :item_count).by(-1)
    end
  end
end
