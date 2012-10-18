require 'spec_helper'

describe PlacesController do
  let(:guest) { FactoryGirl.create(:user, :guest) }
  let(:regular) { FactoryGirl.create(:user, :regular) }
  let(:bob_regular) { FactoryGirl.create(:user, :regular) }
  
  describe "GET index" do
    before :each do
      @private = FactoryGirl.create_list(:place, 2, :private, user: regular)
      @business = FactoryGirl.create_list(:place, 2, :business, user: regular)
      @public = FactoryGirl.create_list(:place, 2, :public, user: regular)
    end
    
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
    
    context "with no logged user" do
      it "populates an array of public and business places" do
        get :index
        assigns(:places).should match_array @public + @business
      end
    end
    
    context "with regular user logged in" do
      it "populates an array of places" do
        sign_in regular
        get :index
        assigns(:places).should match_array @private + @public + @business   
      end
    end 
  end
  
  describe "GET location" do
    before :each do
      @berlin = FactoryGirl.create( :place, :private, city: "Berlin")
      @berlin.latitude = "43.9680364";
      @berlin.longitude = "-88.9434476";
      @berlin.save!
      @new_york = FactoryGirl.create(:place, :public, city: "New York")
      @new_york_private = FactoryGirl.create(:place, :private, city: "New York")
    end
    
    it "renders the :index view" do
      get :index, cities: ["New York"]
      response.should render_template :index
    end
    
    context "with no logged user" do
      it "populate an array of public places" do
        get :index, cities: ["New York"]
        assigns(:places).should include @new_york
        assigns(:places).should_not include @new_york_private
        assigns(:places).should_not include @berlin
      end
    end
    
    context "with regular user logged in" do
      it "populates an array of places" do
        sign_in regular
        get :index, cities: ["New York"]
        assigns(:places).should include @new_york
        assigns(:places).should include @new_york_private   
      end
    end
  end
  
  describe "GET show" do
    before :each do
      @private_place = FactoryGirl.create(:place, :private, user: regular)
      @public_place = FactoryGirl.create(:place, :public, user: regular)
    end

    it "renders the :show view" do
      get :show, id: @public_place
      response.should render_template :show
    end
    
    context "with no logged user" do
      it "assigns requested public place to @place" do
        get :show, id: @public_place
        assigns(:place).should == @public_place
      end
      
      it "redirects to root_url for private place" do
        get :show, id: @private_place
        response.should redirect_to root_url
      end
    end
    
    context "with regular user logged in" do
      it "assigns requested private place to @place" do
        sign_in regular
        get :show, id: @private_place
        assigns(:place).should == @private_place    
      end
    end
  end

  describe "GET new" do
    context "with regular user logged in" do
      it "assigns new Place to @place and render :new view" do
        sign_in regular
        place = regular.places.build
        place.name = "#{regular.name}'s place"
        get :new
        assigns(:place).should be
        response.should render_template :new
      end
    end 
  end

  describe "GET edit" do
    context "with regular user logged in" do
      it "assigns requested place to @place and render :edit view" do
        place = FactoryGirl.create(:place, :private, user: regular)
        sign_in regular
        get :edit, id: place
        assigns(:place).should be
        response.should render_template :edit
      end
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new place" do
        sign_in regular
        expect{
          post :create, place: FactoryGirl.attributes_for(:place, :public)
        }.to change(Place,:count).by(1)
      end
      
      it "assigns newly created Place as @place" do
        sign_in regular
        post :create, place: FactoryGirl.attributes_for(:place, :public)
        assigns(:place).should be_a(Place)
        assigns(:place).should be_persisted
      end
      
      it "redirects to the new place" do
        sign_in regular
        post :create, place: FactoryGirl.attributes_for(:place, :public)
        response.should redirect_to Place.last
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new place" do
        sign_in regular
        expect{
          post :create, place: FactoryGirl.attributes_for(:place, :public, name: nil)
        }.to_not change(Place,:count)
      end
      
      it "re-render the new method" do
        sign_in regular
        post :create, place: FactoryGirl.attributes_for(:place, :public, name: nil)
        response.should render_template "new"
      end
    end 
  end

  describe "PUT update" do
    before :each do
      @place = FactoryGirl.create(:place, :private, user: regular, name: "Bob Place", desc: "Short Bob Place desc")
    end
    
    context "with valid attributes" do
      it "licated the requested place" do 
        sign_in regular
        put :update, id: @place, place: FactoryGirl.attributes_for(:place, :private)
        assigns(:place).should eq(@place)
      end
      
      it "changes @place attributes" do
        sign_in regular
        put :update, id: @place, place: { name: "Place", desc: "Short Place desc" }
        @place.reload
        @place.name.should eq("Place")
        @place.desc.should eq("Short Place desc")
      end
      
      it "redirects to the updated place" do
        sign_in regular
        put :update, id: @place, place: FactoryGirl.attributes_for(:place, :private)
        @place.reload
        response.should redirect_to @place
      end
    end     
   
    context "invalid attributes" do
      it "locates the requested @place" do
        sign_in regular
        put :update, id: @place, place: FactoryGirl.attributes_for(:place, :private, name: nil)
        assigns(:place).should eq(@place)      
      end
    
      it "does not change @place's attributes" do
        sign_in regular
        put :update, id: @place, place: FactoryGirl.attributes_for(:place, :private, name: "Josh", desc: nil)
        @place.reload
        @place.name.should_not eq("Josh")
        @place.desc.should eq("Short Bob Place desc")
      end
      
      it "re-renders the edit method" do
        sign_in regular
        put :update, id: @place, place: FactoryGirl.attributes_for(:place, :private, name: nil)
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      @place = FactoryGirl.create(:place, :private, user: regular)
    end
    
    context "with regular user logged in" do
      it "deletes the place" do
        sign_in regular
        expect{
          delete :destroy, id: @place        
        }.to change(Place,:count).by(-1)
      end
      
      it "redirects to places#index" do
        sign_in regular
        delete :destroy, id: @place
        response.should redirect_to places_url
      end
    end
    
    context "with no logged user" do
      it "doesn't delete the place" do
        expect{
          delete :destroy, id: @place
        }.to_not change(Place,:count)
      end
      
      it "should redirect to login page" do
        delete :destroy, id: @place
        response.should redirect_to new_user_session_url
      end 
    end 
  end
  
  describe "GET submitted" do
    before :each do
      @josh_places = FactoryGirl.create_list(:place, 3, :public, user: regular)
      @bob_places = FactoryGirl.create_list(:place, 5, :public, user: bob_regular)
    end
    
    context "with bob logged in" do
      it "populates an array of bob places" do
        sign_in bob_regular
        get :submitted
        Place.all.size.should == @bob_places.size + @josh_places.size
        assigns(:places).size == @bob_places.size
        response.should render_template  "places"
      end
    end
  end
  
end
