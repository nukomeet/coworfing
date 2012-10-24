require 'spec_helper'

describe Identity do
  before :each do
    @user = FactoryGirl.create(:user, :regular)
    @identity = FactoryGirl.create(:identity)
  end

  it "has a valid facotry" do
    FactoryGirl.create(:identity, user: @user)
  end

  it "is invalid without a uid and provider" do
    FactoryGirl.build(:identity, uid: nil, provider: nil, user: @user).should_not be_valid
  end

  it "is invalid without user" do
    FactoryGirl.build(:identity, user: nil).should_not be_valid
  end
end
