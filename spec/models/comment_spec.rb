require 'spec_helper'

describe Comment do
  it "has a valid facotry" do
    FactoryGirl.create(:comment)
  end 

  it "is invalid without a content" do
    FactoryGirl.build(:comment, content: nil).should_not be_valid
  end

  it "is invalid with a content shorter than 5 characters" do
    FactoryGirl.build(:comment, content: String.random_alphanum(4) ).should_not be_valid
  end
  
  it "is invalid with a content longer than 500 characters" do
    FactoryGirl.build(:comment, content: String.random_alphanum(501) ).should_not be_valid
  end
end
