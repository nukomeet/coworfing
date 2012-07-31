require 'spec_helper'

describe PlaceRequest do
  it "has a valid facotry" do
    FactoryGirl.create(:place_request)
  end 

  it "is invalid without a requested_on date" do
    FactoryGirl.build(:place_request, requested_on: nil).should_not be_valid
  end

  it "is invalid without a body" do
    FactoryGirl.build(:place_request, body: nil).should_not be_valid
  end

  it "is invalid with a body shorter than 5 characters" do
    FactoryGirl.build(:place_request, body: String.random_alphanum(4) ).should_not be_valid
  end
  
  it "is invalid with a body longer than 500 characters" do
    FactoryGirl.build(:place_request, body: String.random_alphanum(501) ).should_not be_valid
  end
end
