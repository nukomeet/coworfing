class PlacesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_owner, only: [:update, :create]
  load_and_authorize_resource

  helper_method :owners

  def submitted
    @places = @places.accessible_by(current_ability).order(:created_at).page params[:page]
    render 'places'
  end

  def index
    if params[:tag]
      @places = @places.tagged_with(params[:tag]).page params[:page]
    else
      @places_all = @places.location(params[:cities])
      @places = @places_all.page(params[:page])
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @nearbys = @place.nearbys(0.5, {:units => :km})
    @workers = @place.checkin_users

    @checkin = @place.checkins.where(user_id: current_user).first
  end

  def new
    @place.name = "#{current_user.name}'s place"
    @place.photos.build()
    @owner = current_user
  end

  def edit
    @owner = @place.owner
    @place.photos.build() if @place.photos.blank?
  end

  def create
    @place.owner = @owner
    @place.desc = view_context.escape_javascript(@place.desc)

    if @place.save
      redirect_to @place
    else
      render action: "new"
    end
  end

  def update
    @place.owner = @owner

    if @place.update_attributes(params[:place])
      redirect_to @place, notice: 'Place was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  def owners
    [current_user] + current_user.organizations.to_a
  end

  def find_owner
    @owner = Organization.where(name: params[:owner]).first || User.where(username: params[:owner]).first
  end
end
