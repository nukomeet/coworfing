class HomeController < ApplicationController
  def index
    @user_count = User.count
    @place_count = Place.count
    @place_req_count = PlaceRequest.count
  end

  def map
    @places = Place.all
    @place_names = Place.uniq.pluck(:city)
    authorize! :see, :places
    respond_to do |format|
      format.html 
      format.json { }
    end
  end

  def location    
    mapQuery = Geocoder.coordinates(params[:query])
    @location = { 'userLocation' => request.location, 'queryResult' => mapQuery}
    puts @location.inspect
    respond_to do |format|
      format.html 
      format.json { render json: @location }
    end
  end
end
