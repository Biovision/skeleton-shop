require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validation' do
    it 'passes with valid attributes' do
      category = build :category
      expect(category).to be_valid
    end

    it 'fails without name' do
      category = build :category, name: ' '
      expect(category).not_to be_valid
    end

    it 'fails without slug' do
      category = build :category, slug: ' '
      expect(category).not_to be_valid
    end

    it 'fails with non-unique name' do
      existing = create :category
      category = build :category, name: existing.name
      expect(category).not_to be_valid
    end

    it 'fails with non-unique slug' do
      existing = create :category
      category = build :category, slug: existing.slug
      expect(category).not_to be_valid
    end

    it 'fails with too priority less than 1' do
      category = build :category, priority: 0
      expect(category).not_to be_valid
    end
  end
end
