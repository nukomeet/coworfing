require 'spec_helper'

describe OrganizationsController do
  let(:guest) { FactoryGirl.create(:user, :guest) }
  let(:regular) { FactoryGirl.create(:user, :regular) }
  let(:organization_admin) { FactoryGirl.create(:user, :regular) }
  let(:organization) { FactoryGirl.create(:organization) }
  let(:organization_outside) { FactoryGirl.create(:organization) }
  let!(:membership) { FactoryGirl.create(:membership, :admin, user: organization_admin, organization: organization) }

  describe "GET index" do
    context "with no logged user" do
      it "redirects to root url" do
        get :index
        response.should redirect_to new_user_session_url
      end
    end

    context "with user logged in" do
      context "user is organization member" do
        it "populates an array of organizations" do
          sign_in organization_admin
          get :index
          assigns(:organizations).should match_array([organization])
        end
      end
      context "user is not organization member" do
        it "populates an array of organizations" do
          sign_in regular
          get :index
          assigns(:organizations).should match_array []
        end
      end
    end
  end

  describe "GET new" do
    context "with user logged in" do
      it "render a new organization view" do
        sign_in organization_admin
        get :new
        assigns(:organization).should be
        response.should render_template :new
      end
    end

    context "with user not logged in" do
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new organization" do
        sign_in organization_admin
        expect {
          post :create, organization: FactoryGirl.attributes_for(:organization)
        }.to change(Organization,:count).by(1)
      end

      it "assigns newly created Organization as @organization" do
        sign_in organization_admin
        post :create, organization: FactoryGirl.attributes_for(:organization)
        assigns(:organization).should be_a(Organization)
        assigns(:organization).should be_persisted
      end

      it "redirects to the new organization" do
        sign_in organization_admin
        post :create, organization: FactoryGirl.attributes_for(:organization)
        response.should redirect_to Organization.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new organization" do
        sign_in organization_admin
        expect{
          post :create, organization: FactoryGirl.attributes_for(:organization, name: nil)
        }.to_not change(Organization, :count)
      end

      it "re-render the new method" do
        sign_in regular
        post :create, organization: FactoryGirl.attributes_for(:organization, name: nil)
        response.should render_template "new"
      end
    end
  end



end
