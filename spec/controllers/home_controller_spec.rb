require 'spec_helper'

describe HomeController do
  let(:regular) { FactoryGirl.create(:user, :regular) }

=begin
  describe "GET 'index'" do
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end

    it "assigns variables" do
      get :index
      assigns(:user_count).should be
      assigns(:place_count).should be
      assigns(:place_req_count).should be
    end
  end
=end

  describe "GET map" do
=begin
    context "with no user logged" do
      it "redirects to root_url" do
        get :map
        response.should redirect_to root_url
      end
    end
=end
    context "with regular user logged in" do
      it "renders the :map view" do
        sign_in regular
        get :map
        response.should render_template :map
      end

      it "assigns Places to @places" do
        @private = FactoryGirl.create_list(:place, 5, :private, owner: regular)
        @public = FactoryGirl.create_list(:place, 5, :public, owner: regular)
        sign_in regular
        get :map
        assigns(:places).should match_array(@private + @public)
      end
    end
  end

end
