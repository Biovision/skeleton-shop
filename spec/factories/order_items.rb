FactoryGirl.define do
  factory :order_item do
    order
    item
    quantity 1
    price 1
  end
end
