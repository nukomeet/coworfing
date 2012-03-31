class RegistrationsController < ApplicationController
  def new
    flash[:failure] = "Registration not allowed" 
    redirect_to root_path
  end
end
