FactoryGirl.define do
  factory :brand do
    sequence(:name) { |n| "Brand #{n}" }
    sequence(:slug) { |n| "brand-#{n}" }
  end
end
