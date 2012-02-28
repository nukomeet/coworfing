class HomeController < ApplicationController
  def index
    render :layout => 'landing'
    @users = User.all
  end
end
