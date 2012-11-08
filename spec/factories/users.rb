# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    username { String.random_alphanum(10) }
    email { Faker::Internet.email }
    password { String.random_alphanum(10) }
    password_confirmation {|o| o.password }
    # required if the Devise Confirmable module is used
    confirmed_at Time.now

    trait :regular do
      role :regular
    end

    trait :admin do
      role :admin
    end

    factory :user_with_linkedin do
      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:identity, 1, user: user, provider: 'linkedin')
      end
    end

  end
end
