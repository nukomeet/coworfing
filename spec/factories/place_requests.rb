# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :place_request do
    active false
    requested_on "2012-07-11 16:54:25"
    body "MyText"
  end
end
