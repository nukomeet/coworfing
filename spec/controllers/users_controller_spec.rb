require 'spec_helper'

describe UsersController do
  let(:regular) { FactoryGirl.create(:user, :regular, public: true) }
  let(:admin) { FactoryGirl.create(:user, :admin, public: true) }
  
  describe "GET 'show'" do 
    before :each do
      @private = FactoryGirl.create(:user, :regular, public: false)
      @public = FactoryGirl.create(:user, :regular, public: true)
    end
    
    it "renders the :show view" do
      get :show, username: @public.username
      response.should render_template :show
    end
    
    context "whit no logged user" do
      it "redirects to root_url for private user" do
        get :show, username: @private.username
        response.should redirect_to root_url
      end
      
      it "assigns public User to @user" do
        get :show, username: @public.username
        assigns(:user).should == @public
      end
    end
    
    context "whit regular user logged in" do
      it "renders the :show view" do
        sign_in regular
        get :show, username: @private.username
        response.should render_template :show
      end
      
      it "assigns public User to @user" do
        get :show, username: @private.username
        assigns(:user).should == @private
      end
    end
  end
  
  describe "GET 'edit'" do 
    before :each do
      @user = FactoryGirl.create(:user, :regular, public: false)
    end
        
    context "whit no admin user" do
      it "redirects to sign_in for not logged user" do
        get :edit, id: @user.id
        response.should redirect_to new_user_session_url
      end
      
      it "redirects to root_url for regular user logged in" do
        sign_in regular        
        get :edit, id: @user.id
        response.should redirect_to root_url
      end
    end
    
    context "whit admin user logged in" do
      it "renders the :edit view" do
        sign_in admin
        get :edit, id: @user.id
        response.should render_template :edit
      end
      
      it "assigns public User to @user" do
        sign_in admin
        get :edit, id: @user.id
        assigns(:user).should == @user
      end
    end
  end
  
  
  describe "GET 'update'" do 
    before :each do
      @user = FactoryGirl.create(:user, :regular, public: false, twitter: "twitter_name")
    end
    
    context "with valid attributes" do
      it "licated the requested user" do 
        sign_in admin
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, current_password: "")
        assigns(:user).should eq(@user)
      end
      
      it "changes @user attributes" do
        sign_in admin
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, current_password: "", twitter: "twitter")
        @user.reload
        @user.twitter.should eq("twitter")
      end
      
      it "redirects to the edit user" do
        sign_in admin
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, current_password: "")
        response.should redirect_to edit_user_url(@user)
      end
    end     
   
    context "invalid attributes" do
      it "locates the requested @user" do
        sign_in admin
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, username: nil, current_password: "")
        assigns(:user).should eq(@user)      
      end
    
      it "does not change @users's attributes" do
        sign_in admin
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, twitter: "twitter", username: nil, current_password: "")
        @user.reload
        @user.twitter.should_not eq("twitter")
      end
      
      it "re-renders the edit method" do
        sign_in admin
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, username: nil, current_password: "")
        response.should render_template :edit
      end
    end
  end
  
  
  describe "GET 'index'" do 
    before :each do
      @private = FactoryGirl.create_list(:user, 5, :regular, public: false)
      @public = FactoryGirl.create_list(:user, 5,  :regular, public: true)
    end
    
    it "renders the :show view" do
      get :index
      response.should render_template :index
    end
    
    context "whit no logged user" do      
=begin
      it "assigns public Users to @users" do
        get :index
        assigns(:users).should == @public + [regular]
      end
=end
    end
    
    context "whit regular user logged in" do
      it "renders the :show view" do
        sign_in regular
        get :index
        response.should render_template :index
      end
      
      it "assigns public Users to @users" do
        sign_in regular
        get :index
        assigns(:users).should =~ @private + @public + [regular]
      end
    end
  end
  
end
