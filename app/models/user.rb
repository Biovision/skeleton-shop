class User < ActiveRecord::Base
  has_many :user_roles, dependent: :destroy

  has_secure_password
  validates_presence_of :login
  validates_uniqueness_of :login
end
