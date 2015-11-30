class Brand < ActiveRecord::Base
  include HasUniqueNameAndSlug

  has_many :items, dependent: :nullify
end
