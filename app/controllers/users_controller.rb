class UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource only: [:index, :edit, :update]

  def show
    @owner = User.by_username(params[:username]).first || Organization.by_name(params[:username]).first
    if @owner.nil?
      redirect_to people_url, alert: 'User not found!'
    else
      @places = @owner.checkin_places.accessible_by(current_ability)
      authorize! :show, @owner
    end
  end

  def index
    @users = @users.with_username

    respond_to do |format|
      format.html # index.html.erb
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
