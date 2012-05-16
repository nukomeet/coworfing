class HomeController < ApplicationController
  def index
    @user_count = User.all.count
    @place_count = Place.all.count
    @place_req_count = PlaceRequest.all.count
  end

  def map
    @places = []
    authorize! :see, :places

    @places = Place.limit(params[:limit].to_i)

    respond_to do |format|
      format.html 
      format.json { }
    end
  end

  def location
    @location = { 'city' => request.location.city, 'country' => request.location.country }
    respond_to do |format|
      format.html 
      format.json { render json: @location }
    end
  end
end
