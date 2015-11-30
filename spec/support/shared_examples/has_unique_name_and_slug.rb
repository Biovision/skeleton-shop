require 'rails_helper'

RSpec.shared_examples_for 'has_unique_name_and_slug' do
  let(:model) { described_class.to_s.underscore.to_sym }

  describe 'validation' do
    it 'fails without name' do
      entity = build model, name: ' '
      expect(entity).not_to be_valid
    end

    it 'fails without slug' do
      entity = build model, slug: ' '
      expect(entity).not_to be_valid
    end

    it 'fails with non-unique name' do
      existing = create model
      entity   = build model, name: existing.name
      expect(entity).not_to be_valid
    end

    it 'fails with non-unique slug' do
      existing = create model
      entity   = build model, slug: existing.slug
      expect(entity).not_to be_valid
    end
  end
end
