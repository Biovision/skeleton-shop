require 'rails_helper'

RSpec.describe BrandCategory, type: :model do
  it_behaves_like 'has_mandatory_category'

  describe 'validation' do
    it 'passes with valid attributes' do
      brand_category = build :brand_category
      expect(brand_category).to be_valid
    end

    it 'fails without brand' do
      brand_category = build :brand_category, brand_id: nil
      expect(brand_category).not_to be_valid
    end

    it 'fails with non-unique pair' do
      existing = create :brand_category
      brand_category = build :brand_category, brand_id: existing.brand_id, category_id: existing.category_id
      expect(brand_category).not_to be_valid
    end
  end

  describe 'after creation' do
    let!(:category) { create :category }

    it 'increases brand_count in category' do
      action = -> { create :brand_category, category: category }
      expect(action).to change(category, :brand_count).by(1)
    end
  end

  describe 'after destruction' do
    it 'decreases brand_count in category' do
      brand_category = create :brand_category
      action = -> { brand_category.destroy }
      expect(action).to change(brand_category.category, :brand_count).by(-1)
    end
  end
end
