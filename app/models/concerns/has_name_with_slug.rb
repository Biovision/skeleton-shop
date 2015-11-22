module HasNameWithSlug
  extend ActiveSupport::Concern

  included do
    validates_presence_of :name, :slug
    validates_uniqueness_of :name, :slug

    scope :by_slug, -> { order 'slug asc' }
    scope :by_name, -> { order 'name asc' }
  end

  module ClassMethods
  end
end
