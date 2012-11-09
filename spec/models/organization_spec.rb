require 'spec_helper'

describe Organization do
  it "has a valid factory" do
    FactoryGirl.create(:organization)
  end

  it "is invalid without a name" do
    FactoryGirl.build(:organization, name: nil).should_not be_valid
  end

  it "is invalid with name shorter than 5 characters" do
    FactoryGirl.build(:organization, name: String.random_alphanum(4) ).should_not be_valid
  end

  it "is invalid with name longer than 45 characters" do
    FactoryGirl.build(:organization, name: String.random_alphanum(46) ).should_not be_valid
  end

end
