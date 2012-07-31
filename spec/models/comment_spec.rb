require 'spec_helper'

describe Comment do
  before :each do
    @user = FactoryGirl.create(:user, :regular)
    @place = FactoryGirl.create(:place, :public)
  end
  
  
  it "has a valid facotry" do
    FactoryGirl.create(:comment, user: @user, place: @place)
  end 

  it "is invalid without a content" do
    FactoryGirl.build(:comment, content: nil, user: @user, place: @place).should_not be_valid
  end

  it "is invalid with a content shorter than 5 characters" do
    FactoryGirl.build(:comment, content: String.random_alphanum(4),user: @user, place: @place ).should_not be_valid
  end
  
  it "is invalid with a content longer than 500 characters" do
    FactoryGirl.build(:comment, content: String.random_alphanum(501), user: @user, place: @place ).should_not be_valid
  end
    
  it "is invalid without user" do
    FactoryGirl.build(:comment, user: nil, place: @place).should_not be_valid 
  end
  
  it "is invalid without place" do
    FactoryGirl.build(:comment, place: nil, user: @user).should_not be_valid 
  end
  
end
