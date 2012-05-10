class UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:index]
  load_and_authorize_resource

  def show
    @user = User.first(conditions: { username: params[:username] })
  end

  def index
    @users = User.accessible_by(current_ability)
  end
end
