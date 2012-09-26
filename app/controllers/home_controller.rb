class HomeController < ApplicationController
  def index
    @user_count = User.count
    @place_count = Place.count
    @place_req_count = PlaceRequest.count
  end

  def map
    @places = Place.all
    @location = request.location
    authorize! :see, :places
    respond_to do |format|
      format.html 
      format.json { }
    end
  end

  def location    
    mapQuery = Geocoder.coordinates(params[:query])
    @location = {'queryResult' => mapQuery}
    
    respond_to do |format|
      format.html 
      format.json { render json: @location }
    end
  end
  
  def mobile
  end
end
