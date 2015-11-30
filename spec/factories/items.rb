FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "Товар #{n}" }
    sequence(:slug) { |n| "item-#{n}" }
  end
end
