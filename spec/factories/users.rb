FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "user-#{n}" }
    password 'secret'
    password_confirmation 'secret'
  end
end
