require 'spec_helper'

describe OrganizationsController do
  let(:guest) { FactoryGirl.create(:user, :guest) }
  let(:regular) { FactoryGirl.create(:user, :regular) }
  let(:organization) { FactoryGirl.create(:organization) }
  let(:organization_admin) { FactoryGirl.create(:user, :regular) }


  # This should return the minimal set of attributes required to create a valid
  # Organization. As you add validations to Organization, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OrganizationsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all organizations as @organizations" do
      organization = Organization.create! valid_attributes
      get :index, {}, valid_session
      assigns(:organizations).should eq([organization])
    end
  end

  describe "GET show" do
    it "assigns the requested organization as @organization" do
      organization = Organization.create! valid_attributes
      get :show, {:id => organization.to_param}, valid_session
      assigns(:organization).should eq(organization)
    end
  end

  describe "GET new" do
    it "assigns a new organization as @organization" do
      get :new, {}, valid_session
      assigns(:organization).should be_a_new(Organization)
    end
  end

  describe "GET edit" do
    it "assigns the requested organization as @organization" do
      organization = Organization.create! valid_attributes
      get :edit, {:id => organization.to_param}, valid_session
      assigns(:organization).should eq(organization)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Organization" do
        expect {
          post :create, {:organization => valid_attributes}, valid_session
        }.to change(Organization, :count).by(1)
      end

      it "assigns a newly created organization as @organization" do
        post :create, {:organization => valid_attributes}, valid_session
        assigns(:organization).should be_a(Organization)
        assigns(:organization).should be_persisted
      end

      it "redirects to the created organization" do
        post :create, {:organization => valid_attributes}, valid_session
        response.should redirect_to(Organization.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved organization as @organization" do
        # Trigger the behavior that occurs when invalid params are submitted
        Organization.any_instance.stub(:save).and_return(false)
        post :create, {:organization => {}}, valid_session
        assigns(:organization).should be_a_new(Organization)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Organization.any_instance.stub(:save).and_return(false)
        post :create, {:organization => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested organization" do
        organization = Organization.create! valid_attributes
        # Assuming there are no other organizations in the database, this
        # specifies that the Organization created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Organization.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => organization.to_param, :organization => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested organization as @organization" do
        organization = Organization.create! valid_attributes
        put :update, {:id => organization.to_param, :organization => valid_attributes}, valid_session
        assigns(:organization).should eq(organization)
      end

      it "redirects to the organization" do
        organization = Organization.create! valid_attributes
        put :update, {:id => organization.to_param, :organization => valid_attributes}, valid_session
        response.should redirect_to(organization)
      end
    end

    describe "with invalid params" do
      it "assigns the organization as @organization" do
        organization = Organization.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Organization.any_instance.stub(:save).and_return(false)
        put :update, {:id => organization.to_param, :organization => {}}, valid_session
        assigns(:organization).should eq(organization)
      end

      it "re-renders the 'edit' template" do
        organization = Organization.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Organization.any_instance.stub(:save).and_return(false)
        put :update, {:id => organization.to_param, :organization => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested organization" do
      organization = Organization.create! valid_attributes
      expect {
        delete :destroy, {:id => organization.to_param}, valid_session
      }.to change(Organization, :count).by(-1)
    end

    it "redirects to the organizations list" do
      organization = Organization.create! valid_attributes
      delete :destroy, {:id => organization.to_param}, valid_session
      response.should redirect_to(organizations_url)
    end
  end

end
