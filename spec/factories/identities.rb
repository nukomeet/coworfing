# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    uid { Faker::Name.name }
    provider { Faker::Name.name }
    association :user
  end

end
