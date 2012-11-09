class OrganizationsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  load_and_authorize_resource except: [:new, :create, :show]

  def index
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def new
    @organization = Organization.new
  end

  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(params[:organization])
    @organization.memberships.build(role: :admin, user_id: current_user.id)

    if @organization.save
      redirect_to @organization, notice: 'Organization was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @organization.update_attributes(params[:organization])
      redirect_to organizations_path, notice: 'Organization was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end
end
