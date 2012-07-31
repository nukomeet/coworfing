# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :place_request do
    requested_on "2012-07-11 16:54:25"
    body { Faker::Lorem.paragraph(1) }
  end
end
