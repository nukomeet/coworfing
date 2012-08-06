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
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
    email_changed = @user.email != params[:user][:email]
    password_changed = !params[:user][:password].empty?
    successfully_updated = if email_changed or password_changed
      @user.update_with_password(params[:user])
    else
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render template_path
    end
  end
  
  def template_path
    path = Rails.application.routes.recognize_path(request.referer, :method=>:get)
    puts path.to_yaml
    return path[:action]
  end
end
