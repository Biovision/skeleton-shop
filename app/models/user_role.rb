class UserRole < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :role
  validates_uniqueness_of :user_id, scope: [:role]

  enum role: [:administrator]
end
