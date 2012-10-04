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
  
  def mobile
  end

  def fb
    @facebook_cookies ||= Koala::Facebook::OAuth.new 
    @access_token = @facebook_cookies["access_token"]
    @graph = Koala::Facebook::GraphAPI.new(@access_token)
  end
end
