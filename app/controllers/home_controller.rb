class HomeController < ApplicationController
  def index
  end

  def places
    @places = Place.limit(params[:limit].to_i)

    respond_to do |format|
      format.html 
      format.json { }
    end
  end
end
