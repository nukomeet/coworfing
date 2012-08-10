require 'spec_helper'

describe User do

  it "has a valid factory" do
    FactoryGirl.create(:user)
  end

  it "is invalid without an email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end
  
  it "accepts valid email address" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      FactoryGirl.build(:user, email: address).should be_valid
    end
  end
  
  it "rejects invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      FactoryGirl.build(:user, email: address).should_not be_valid
    end
  end
  
  it "is invalid with non-uniq email" do
    FactoryGirl.create(:user, email: 'oh@zaiste.net')
    FactoryGirl.build(:user, email: 'oh@zaiste.net').should_not be_valid
  end
  
  
  describe "passwords" do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "has a password attribute" do
      @user.should respond_to(:password)
    end

    it "has a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end
  
  describe "password validations" do

    it "should require a password" do
      FactoryGirl.build(:user, password: nil, password_confirmation: nil).should_not be_valid
    end

    it "requires a matching password confirmation" do
      FactoryGirl.build(:user, password_confirmation: 'invalid').should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      FactoryGirl.build(:user, password: short, password_confirmation: short).should_not be_valid
    end
    
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    
    it "has an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "sets the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end
  
  describe "valid_attribute?" do
    before :each do
      @bob = FactoryGirl.create(:user, :regular, email: "bob@dot.com") 
    end
   
   context "valid attribute" do
      params = { email: "jerry@dot.com"}
      it "returns true" do
        User.valid_attribute?(:email, params).should == true
      end
   end
   
   context "invalid attribute" do
      params = { email: "bob@dot.com"}
      it "returns false" do 
        User.valid_attribute?(:email, params).should == false
      end
   end 
  end
end
