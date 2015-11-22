require 'rails_helper'

RSpec.describe Category, type: :model do
  it_behaves_like 'has_name_with_slug'

  describe 'validation' do
    it 'passes with valid attributes' do
      category = build :category
      expect(category).to be_valid
    end

    it 'fails with too priority less than 1' do
      category = build :category, priority: 0
      expect(category).not_to be_valid
    end
  end
end
