class Category < ActiveRecord::Base
  include HasNameWithSlug

  validates_numericality_of :priority, greater_than: 0
end
