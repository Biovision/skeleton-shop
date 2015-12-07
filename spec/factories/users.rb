FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "user-#{n}" }
    password 'secret'
    password_confirmation 'secret'

    factory :administrator do
      after :create do |user|
        user.add_role :administrator
      end
    end
  end
end
