class PlacesController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, except: [:index, :show]

  def submitted
    @places = @places.order(:created_at).page params[:page] 
    render 'places'
  end

  def index
    @place_names = @places.uniq.pluck(:city)
    @places = @places.city(params[:cities]).page(params[:page])

    respond_to do |format|
      format.html 
      format.json { render json: @places }
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def create
    @place.user = current_user

    respond_to do |format|
      if @place.save
        format.html {redirect_to @place}
        if current_user.places.count == 3
          Notification.become_cow_email(current_user).deliver
          flash[:notice] = 'Congratulations! You just shared a place. Now you have access private places!'
        else
          flash[:notice] =  'Great, your place was successfully created.' 
        end
        format.json { render json: @place, status: :created, location: @place }
      else
        format.html { render action: "new" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.json
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
end
