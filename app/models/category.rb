class Category < ActiveRecord::Base
  validates_presence_of :name, :slug
  validates_uniqueness_of :name, :slug
  validates_numericality_of :priority, greater_than: 0
end
