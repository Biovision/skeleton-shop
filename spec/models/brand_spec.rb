require 'rails_helper'

RSpec.describe Brand, type: :model do
  it_behaves_like 'has_name_with_slug'

  describe 'validation' do
    it 'passes with valid attributes' do
      brand = build :brand
      expect(brand).to be_valid
    end
  end
end
