class DemandsController < ApplicationController
 before_filter :authenticate_user!, except: [:create]

  def index
    @demands = User.all 
    authorize! :read, :demands
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @demands }
    end
  end
  
  def create    
    respond_to do |format|
      if User.valid_attribute?(:email, params[:user])
        @demand = User.new (params[:user])
        @demand.role = "regular"
        @demand.skip_invitation = true
        @demand.invite!
        format.html { redirect_to root_url, notice: 'Invitation Request was successfully sent.' }
      else
        format.html { render "/home/index" }
      end
    end
  end
  
  def accept
    @user = User.find(params[:id])
    authorize! :invite, @user
    @user.invite!
    
    respond_to do |format|
      format.html { redirect_to demands_url }
    end
  end
end
