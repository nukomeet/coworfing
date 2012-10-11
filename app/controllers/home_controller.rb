class HomeController < ApplicationController
  def index
    @user_count = User.count
    @place_count = Place.count
    @place_req_count = PlaceRequest.count
  end

  def map
    @places = Place.all(:include => :photos)
    @location = request.location
    respond_to do |format|
      format.html 
      format.json { }
    end
  end
  
  def mobile
  end

end
