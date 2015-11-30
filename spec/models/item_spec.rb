require 'rails_helper'

RSpec.describe Item, type: :model do
  it_behaves_like 'has_unique_name_and_slug'

  describe 'validation' do
    it 'passes with valid attributes' do
      item = build :item
      expect(item).to be_valid
    end

    it 'passes with null price' do
      item = build :item, price: nil
      expect(item).to be_valid
    end

    it 'fails with price less than 1' do
      item = build :item, price: 0
      expect(item).not_to be_valid
    end
  end
end
