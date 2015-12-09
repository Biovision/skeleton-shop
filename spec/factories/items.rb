FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "Товар #{n}" }
    sequence(:slug) { |n| "item-#{n}" }

    factory :item_with_price do
      price 10
    end
  end
end
