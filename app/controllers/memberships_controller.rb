class MembershipsController < ApplicationController
  def index
    @organization = Organization.find(params[:organization_id])
    @memberships = Membership.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memberships }
    end
  end

  def show
    @organization = Organization.find(params[:organization_id])
    @membership = Membership.find(params[:id])
  end

  def new
    @organization = Organization.find(params[:organization_id])
    @membership = Membership.new
  end

  def edit
    @membership = Membership.find(params[:id])
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @membership = Membership.new(params[:membership])

    if @membership.save
      redirect_to [@organization, @membership], notice: 'Membership was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @membership = Membership.find(params[:id])

    respond_to do |format|
      if @membership.update_attributes(params[:membership])
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to memberships_url }
      format.json { head :no_content }
    end
  end
end
