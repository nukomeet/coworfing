# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :place do
    name { Faker::Lorem.words(4).join(" ") }
    desc { Faker::Lorem.paragraph(1) }
    website { Faker::Internet.domain_name }
    wifi { Faker::Lorem.words(2).join("") }
    transport { Faker::Lorem.words(3).join(" ") }
    address_line1 { Faker::Address.street_address }
    address_line2 { Faker::Address.street_address }
    city { Faker::Address.city }
    zipcode { Faker::Address.zip_code }
    country { Faker::Address.country }
    photo { Faker::Internet.domain_name }
    #association :user, :regular
    
    trait :private do
      kind "private"
    end
    
    trait :public do
      kind :public
    end

    trait :business do
      kind :business
    end
  end
end
