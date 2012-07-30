require 'faker'

FactoryGirl.define do
  factory :place do |p|
    p.name { Faker::Lorem.words(7) }
    p.desc { Faker::Lorem.paragraph }
    p.address_line1 { Faker::Address.street_address }
    p.city { Faker::Address.city }
    p.country "France"
    p.kind :private
  end
end
