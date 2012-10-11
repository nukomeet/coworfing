require 'spec_helper'

describe RegistrationsController do
  let(:regular) { FactoryGirl.create(:user, :regular, password: "123qwe", password_confirmation: "123qwe") }
  
  describe "GET new" do
    it "renders new view" do 
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :new
      response.should render_template :new 
    end
    
    it "assigns user" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :new
      assigns(:user).should be_instance_of(User)
    end
  end

  describe "POST create" do
    it "redirects to root_url" do 
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @attrs = { name: "name name", username: "username", email: "name@name.com", password: "password", password_confirmation: "password" }
      post :create, user: @attrs
      assigns(:user).should be_valid
      response.should redirect_to root_url
    end
  end
  
  describe "GET password" do
    context "with logged in user" do
      it "renders the :password view" do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in regular
        get :password
        response.should render_template :password
      end
      
      it "assigns current_user to @user" do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in regular
        get :password
        assigns(:user).should == regular
      end 
    end
  end
  
  describe "PUT update" do
    before :each do
      @attrs = { name: regular.name, username: regular.username, email: regular.email, bio: regular.bio, website: regular.website, twitter: "test", current_password: "123qwe" }
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in regular
    end
    
    context "update with password" do 
      context "with valid attributes" do
        it "redirects to root_url" do
          put :update, user: {email: "test2@test.com", current_password: "123qwe"}
          response.should redirect_to root_url
        end
        
        it "assigns current_user to @user" do
          put :update, user: {email: "test2@test.com", current_password: "123qwe"}
          assigns(:user).should == regular
        end     
      end
      
      context "with invalid attributes" do
        it "renders edit template" do
          put :update, user: {email: "test2@test.com" , current_password: ""}
          response.should render_template :edit
        end
        
        it "assigns current_user to @user" do
          put :update, user: {email: "test2@test.com", current_password: ""}
          assigns(:user).should == regular
        end
      end
    end
    
    context "update without password" do
      it "redirects to root_url" do
        put :update, user: @attrs
        response.should redirect_to root_url
      end
      
      it "assigns current_user to @user" do
        put :update, user: @attrs
        assigns(:user).should == regular
      end     
    end
  end
end
