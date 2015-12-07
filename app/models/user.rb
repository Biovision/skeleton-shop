class User < ActiveRecord::Base
  has_many :user_roles, dependent: :destroy

  has_secure_password
  validates_presence_of :login
  validates_uniqueness_of :login

  def has_role?(role)
    UserRole.user_has_role? self, role
  end
end
