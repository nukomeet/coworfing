class UsersController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!, except: [:show]

  def show
    @user = User.first(conditions: { username: params[:username] })
  end
end
