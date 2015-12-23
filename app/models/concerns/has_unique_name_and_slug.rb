module HasUniqueNameAndSlug
  extend ActiveSupport::Concern

  included do
    validates_presence_of :name, :slug
    validates_uniqueness_of :name, :slug

    scope :ordered_by_slug, -> { order 'slug asc' }
    scope :ordered_by_name, -> { order 'name asc' }
  end

  module ClassMethods
  end

  def slug_for_url
    lowered = slug.mb_chars.downcase.to_s.squish
    lowered.gsub(/[^a-zа-я0-9ё]/, '-').gsub(/-\z/, '')
  end
end
