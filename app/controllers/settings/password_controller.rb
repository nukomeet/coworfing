class Settings::PasswordController < SettingsController
  # TODO: Make in more DRY!!!
  def update
    @user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      sign_in @user, :bypass => true
      redirect_to root_path, notice: 'Password successfuly changed'
    else
      render "edit"
    end
  end
end
