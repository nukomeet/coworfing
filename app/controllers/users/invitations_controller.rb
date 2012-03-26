class Users::InvitationsController < Devise::InvitationsController
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
end
