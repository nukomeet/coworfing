require 'spec_helper'

describe Photo do
  it "has a valid facotry" do
    FactoryGirl.create(:photo)
  end 
  
   it "is invalid without a photo" do
    FactoryGirl.build(:photo, photo: nil).should_not be_valid
  end

end
