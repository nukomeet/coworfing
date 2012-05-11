class Users::InvitationsController < Devise::InvitationsController
  helper_method :after_invite_path_for

   def new
     if cannot?( :invite, User )
       raise CanCan::AccessDenied
     else
        super
     end
   end
   def create
     if cannot?( :invite, User )
       raise CanCan::AccessDenied
     else
       super
     end
   end

   # PUT /resource/invitation
  def update
    self.resource = resource_class.accept_invitation!(params[resource_name])

    resource.role = "regular"

    if resource.errors.empty?
      set_flash_message :notice, :updated
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource){ render :edit }
    end
  end

  def after_invite_path_for(resource)
    root_path(locale: 'en')
  end

end
