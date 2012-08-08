class Users::InvitationsController < Devise::InvitationsController
  helper_method :after_invite_path_for

  def new
    authorize! :invite, User
    super
  end
   
  def create
    authorize! :invite, User
    super
  end

  def after_invite_path_for(resource)
    root_path
  end

end
