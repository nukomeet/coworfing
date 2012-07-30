# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :place do
    name "MyString"
    desc "MyText"
    website "MyString"
    wifi "MyString"
    transport "MyString"
    address_line1 "MyString"
    address_line2 "MyString"
    city "MyString"
    zipcode "MyString"
    country "MyString"
  end
end
