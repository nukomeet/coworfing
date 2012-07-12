class UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  def show
    # TODO security problem: fix when not logged, and user knows username of
    # private provile
    @user = User.first(conditions: { username: params[:username] })
  end

  def index
    @featured = User.where("username IS NOT NULL and photo IS NOT NULL")
    @users = User.where("username IS NOT NULL") - @featured

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users + @featured }
    end
  end
end
