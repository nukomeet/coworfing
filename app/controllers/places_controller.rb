class PlacesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
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
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  def new
    @place.name = "#{current_user.name}'s place"
    @place.photos.build()
    @owner = current_user
  end

  def edit
    @place = Place.find(params[:id])
    @place.photos.build() if @place.photos.blank?
  end

  def create
    puts params[:owner]
    @owner = Organization.where(name: params[:owner]).first || User.where(username: params[:owner]).first
    puts @owner
    @place.owner = @owner

    if @place.save
      redirect_to @place
    else
      render action: "new"
    end
  end

  def update
    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
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
end
