require 'rails_helper'

RSpec.shared_examples_for 'has_mandatory_item' do
  let(:model) { described_class.to_s.underscore.to_sym }

  describe 'validation' do
    it 'fails without item' do
      entity = build model, item_id: nil
      expect(entity).not_to be_valid
    end
  end
end
