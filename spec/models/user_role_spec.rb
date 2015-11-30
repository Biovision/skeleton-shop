require 'rails_helper'

RSpec.describe UserRole, type: :model do
  describe 'validation' do
    it 'passes with valid attributes' do
      user_role = build :user_role
      expect(user_role).to be_valid
    end

    it 'fails without user' do
      user_role = build :user_role, user_id: nil
      expect(user_role).not_to be_valid
    end

    it 'fails without role' do
      user_role = build :user_role, role: nil
      expect(user_role).not_to be_valid
    end

    it 'fails with non-unique pair' do
      existing  = create :user_role
      user_role = build :user_role, user_id: existing.user_id, role: existing.role
      expect(user_role).not_to be_valid
    end
  end
end
