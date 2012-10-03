require 'spec_helper'

describe Place do
  it "has a valid facotry" do
    FactoryGirl.create(:place, :public)
  end 
  
  it "is invalid without a name" do
    FactoryGirl.build(:place, :public, name: nil).should_not be_valid
  end
  
  it "is invalid with name shorter than 5 characters" do
    FactoryGirl.build(:place, :public, name: String.random_alphanum(4) ).should_not be_valid
  end
  
  it "is invalid with name longer than 45 characters" do
    FactoryGirl.build(:place, :public, name: String.random_alphanum(46) ).should_not be_valid
  end
  
  it "is invalid without a desc" do
    FactoryGirl.build(:place, :public, desc: nil).should_not be_valid
  end
  
  it "is invalid with desc shorter than 5 characters" do
    FactoryGirl.build(:place, :public, desc: String.random_alphanum(4) ).should_not be_valid
  end
  
  it "is invalid with desc longer than 500 characters" do
    FactoryGirl.build(:place, :public, desc: String.random_alphanum(501) ).should_not be_valid
  end
  
  it "is invalid without an address_line1" do
    FactoryGirl.build(:place, :public, address_line1: nil).should_not be_valid
  end
  
  it "is invalid without a city" do
    FactoryGirl.build(:place, :public, city: nil).should_not be_valid
  end

  it "is invalid with a city that begins on ends with a space" do
    FactoryGirl.build(:place, :public, city: 'Paris ').should_not be_valid
    FactoryGirl.build(:place, :public, city: ' London Zdroj').should_not be_valid
  end

  it "is valid with a city that has a space inside" do
    FactoryGirl.build(:place, :public, city: 'Londek Zdroj').should be_valid
  end
  
  it "is invalid without a country" do
    FactoryGirl.build(:place, :public, country: nil).should_not be_valid
  end
  
  it "returns a full address as a string" do
    FactoryGirl.create(:place, :public, address_line1: "Baker Rd", city: "NYC", country: "United States").address.should == "Baker Rd, NYC, United States"
  end
  
  describe ".location" do
    before :each do
      @berlin = FactoryGirl.create( :place, :public, city: "Berlin")
      @berlin.latitude = "43.9680364";
      @berlin.longitude = "-88.9434476";
      @berlin.save!
      @new_york = FactoryGirl.create(:place, :public, city: "New York")
    end
    
    context "matching location" do
      it "returns an array of results that match" do
        Place.location("New York").should include @new_york
      end
    end
    
    context "non-matching location" do
      it "doesn't return places that don't contain provided cities" do
        Place.location("New York").should_not include @berlin
      end
    end
    
    context "empty parameter" do
      it "returns all places" do
        Place.location().all.should == [@berlin, @new_york]  
      end
    end  
  end
end
