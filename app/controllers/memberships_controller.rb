class MembershipsController < ApplicationController
  load_and_authorize_resource :organization
  load_and_authorize_resource :membership, through: :organization

  #before_filter :load_organization

  def index
  end

  def new
  end

  def create
    if @membership.save
      redirect_to organization_memberships_path(@organization), notice: 'Membership was successfully created.'
    else
      render action: "new"
    end
  end

  def destroy
    @membership.destroy

    redirect_to organization_memberships_url(@organization)
  end

  private

  def load_organization
    @organization = Organization.find(params[:organization_id])
  end
end
