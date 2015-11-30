module RequiresItem
  extend ActiveSupport::Concern

  included do
    belongs_to :item
    validates_presence_of :item_id
  end

  module ClassMethods
  end
end
