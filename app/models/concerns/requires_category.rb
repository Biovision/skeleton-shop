module RequiresCategory
  extend ActiveSupport::Concern

  included do
    belongs_to :category
    validates_presence_of :category_id
  end

  module ClassMethods
  end
end
