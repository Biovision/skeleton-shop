class UserRole < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :role
  validates_uniqueness_of :user_id, scope: [:role]

  enum role: [:administrator]

  def self.user_has_role?(user, role)
    if self.role_exists? role
      self.where(user: user, role: self.roles[role]).count == 1
    else
      false
    end
  end

  def self.role_exists?(role)
    self.roles.has_key? role
  end
end
