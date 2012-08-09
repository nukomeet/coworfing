require 'spec_helper'

describe UsersController do
  let(:regular) { FactoryGirl.create(:user, :regular, public: true) }
  
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
      it "assigns public Users to @users" do
        get :index
        assigns(:users).should == @public - [regular]
      end
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
