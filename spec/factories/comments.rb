# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.paragraph(1) }
  end
  
  factory :invalid_comment, parent: :comment do |f|
    f.content nil
  end
end
