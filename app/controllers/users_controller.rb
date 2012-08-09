class UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource only: [:index]

  def show
    @user = User.find_by_username(params[:username])
    authorize! :show, @user
  end

  def index
    @featured = @users.with_photo.with_username
    @users = @users.with_username - @featured
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users + @featured }
    end
  end
end
