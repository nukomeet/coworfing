class UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource only: [:index, :edit, :update]

  def show
    @user = User.find_by_username(params[:username]) || User.find(params[:username])
    authorize! :show, @user
  end

  def index
    @featured = @users.with_username.select { |u| u.gravatar? }
    @rest = @users - @featured

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def edit
  end
  
  def update
    params[:user].delete(:current_password)
    respond_to do |format|
      if @user.update_without_password(params[:user])
        format.html { redirect_to edit_user_url(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
