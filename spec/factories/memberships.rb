require 'faker'

FactoryGirl.define do
  factory :membership do
    association :user
    association :organization

    trait :admin do
      role :admin
    end

    trait :regular do
      role :regular
    end
  end
end
