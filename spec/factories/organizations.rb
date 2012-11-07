require 'faker'

FactoryGirl.define do
  factory :organization do
    name { Faker::Company.name }
    gravatar_email { Faker::Internet.email }
  end
end
