require 'faker'

FactoryGirl.define do
  factory :photo do    
    photo {Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/home.jpg'), 'image/jpeg')}
    association :place, :public
  end 
end
