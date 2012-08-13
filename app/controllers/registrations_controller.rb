class RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy, :password]
  
  def new
    flash[:failure] = "Registration not allowed" 
    redirect_to root_path
  end

  def create
    flash[:failure] = "Registration not allowed" 
    redirect_to root_path
  end
  
  def password
    @user = current_user
  end
  
  def update
    @user = current_user
    email_changed = @user.email != params[:user][:email]
    password_changed = false 
    if params[:user][:password]
      password_changed = !params[:user][:password].empty?
    end
    successfully_updated = if email_changed or password_changed
      @user.update_with_password(params[:user])
    else
      params[:user].delete(:current_password)
      @user.update_without_password(params[:user])
    end
    
    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_url
    else
      render template_path
    end
  end
  
  def template_path
    if request.referer
      path = Rails.application.routes.recognize_path(request.referer, :method=>:get)
      return path[:action]
    else
      return :edit
    end
  end
end
