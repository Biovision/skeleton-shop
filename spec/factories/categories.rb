FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Категория #{n}" }
    sequence(:slug) { |n| "Category #{n}" }
  end
end
