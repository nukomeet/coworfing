require 'spec_helper'

describe Place do
  it "has a valid factory" do
    FactoryGirl.create(:place).should be_valid 
  end

  it "is invalid without a name" do
    FactoryGirl.build(:place, name: nil).should_not be_valid 
  end

  it "is invalid without a desc" do
    FactoryGirl.build(:place, desc: nil).should_not be_valid 
  end

  it "returns a place full address as a string" do
    place = FactoryGirl.create(:place, address_line1: '16 Rue de Temple', city: 'Paris', country: 'France')
    place.address.should == '16 Rue de Temple, Paris, France'
  end

  it "returns places that match a given city" do
    london = FactoryGirl.create(:place, city: "London")
    paris = FactoryGirl.create(:place, city: "Paris")
    berlin = FactoryGirl.create(:place, city: "Berlin")

    Place.city("Paris").should == [paris]
  end
end
