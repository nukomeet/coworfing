require 'spec_helper'

describe DemandsController do
  let(:regular) { FactoryGirl.create(:user, :regular) }
  let(:admin) { FactoryGirl.create(:user, :admin) }
  
  describe "GET index" do
    before :each do
      @users = FactoryGirl.create_list(:user, 5, :regular)
    end

    context "with no logged user" do
      it "redirect to root_url" do
        sign_in regular
        get :index
        response.should redirect_to root_url
      end
    end
    
    context "with admin user logged in" do
      it "populates an array of places" do
        sign_in admin
        get :index
        assigns(:demands).should =~ @users + [admin]   
      end
      
      it "renders the :index view" do
        sign_in admin
        get :index
        response.should render_template :index
      end
    end 
  end
  
  describe "PUT accept" do
    before :each do
      @user = FactoryGirl.create(:user, :regular)
    end
    
    context "with admin user logged in" do  
      it "sends user invitation" do
        sign_in admin
        put :accept, id: @user
        @user.reload
        @user.invitation_token.should_not eq nil
        @user.invitation_sent_at.should_not eq nil
        response.should redirect_to demands_url
      end
    end 
  end
  
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new demand" do
        expect{
          post :create, user: { :email => "email@dot.com" }
        }.to change(User,:count).by(1)
      end
      
      it "assigns newly created Demand as @demand" do
        post :create, user: { :email => "email@dot.com" }
        assigns(:demand).should be_a(User)
        assigns(:demand).should be_persisted
      end
      
      it "redirects to root_url" do
        post :create, user: { :email => "email@dot.com" }
        response.should redirect_to root_url
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new demand" do
        expect{
          post :create, user: { :email => "" }
        }.to_not change(User,:count)
      end
      
      it "re-render the home view" do
        post :create, user: { :email => "" }
        response.should render_template "home/index"
      end
    end 
  end
end
