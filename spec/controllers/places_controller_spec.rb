require 'spec_helper'

describe PlacesController do
  let(:guest) { FactoryGirl.create(:user, :guest) }
  let(:regular) { FactoryGirl.create(:user, :regular) }
  
  describe "GET index" do
    before :each do
      @private = FactoryGirl.create_list(:place, 5, :private, user: regular)
      @public = FactoryGirl.create_list(:place, 5, :public, user: regular)
    end
    
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
    
    context "with no logged user" do
      it "populates an array of public places" do
        get :index
        assigns(:places).should == @public
      end
    end
    
    context "with regular user logged in" do
      it "populates an array of places" do
        sign_in regular
        get :index
        assigns(:places).should == @private + @public    
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
        #assigns(:place).should =~ place
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
        assigns(:place).should =~ place
        response.should render_template :edit
      end
    end
  end

  describe "POST create" do
=begin
    describe "with valid params" do
      it "creates a new Place" do
        expect {
          post :create, {:place => valid_attributes}, valid_session
        }.to change(Place, :count).by(1)
      end

      it "assigns a newly created place as @place" do
        post :create, {:place => valid_attributes}, valid_session
        assigns(:place).should be_a(Place)
        assigns(:place).should be_persisted
      end

      it "redirects to the created place" do
        post :create, {:place => valid_attributes}, valid_session
        response.should redirect_to(Place.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved place as @place" do
        # Trigger the behavior that occurs when invalid params are submitted
        Place.any_instance.stub(:save).and_return(false)
        post :create, {:place => {}}, valid_session
        assigns(:place).should be_a_new(Place)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Place.any_instance.stub(:save).and_return(false)
        post :create, {:place => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested place" do
        place = Place.create! valid_attributes
        # Assuming there are no other places in the database, this
        # specifies that the Place created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Place.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => place.to_param, :place => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested place as @place" do
        place = Place.create! valid_attributes
        put :update, {:id => place.to_param, :place => valid_attributes}, valid_session
        assigns(:place).should eq(place)
      end

      it "redirects to the place" do
        place = Place.create! valid_attributes
        put :update, {:id => place.to_param, :place => valid_attributes}, valid_session
        response.should redirect_to(place)
      end
    end

    describe "with invalid params" do
      it "assigns the place as @place" do
        place = Place.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Place.any_instance.stub(:save).and_return(false)
        put :update, {:id => place.to_param, :place => {}}, valid_session
        assigns(:place).should eq(place)
      end

      it "re-renders the 'edit' template" do
        place = Place.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Place.any_instance.stub(:save).and_return(false)
        put :update, {:id => place.to_param, :place => {}}, valid_session
        response.should render_template("edit")
      end
    end
=end
  end

  describe "DELETE destroy" do
=begin
    it "destroys the requested place" do
      place = Place.create! valid_attributes
      expect {
        delete :destroy, {:id => place.to_param}, valid_session
      }.to change(Place, :count).by(-1)
    end

    it "redirects to the places list" do
      place = Place.create! valid_attributes
      delete :destroy, {:id => place.to_param}, valid_session
      response.should redirect_to(places_url)
    end
=end
  end

end
