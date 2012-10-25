class OmniauthCallbacksController < Devise::OmniauthCallbacksController  
  def all
    auth = request.env['omniauth.auth']
  
    # Find an identity here
    @identity = Identity.find_with_omniauth(auth)

    if @identity.nil?
      # If no identity was found, create a brand new one here
      @identity = Identity.create_with_omniauth(auth)
    end

    if signed_in?
      if @identity.user == current_user
        # User is signed in so they are trying to link an identity with their
        # account. But we found the identity and the user associated with it
        # is the current user. So the identity is already associated with
        # this user. So let's display an error message.
        
        current_user.skills = fetch_skills_from_linkedin(auth)
        current_user.save
        
        redirect_to root_url, notice: "Already linked that account!"
      else
        # The identity is not associated with the current_user so lets
        # associate the identity
  
        current_user.identities << @identities
        current_user.skills = fetch_skills_from_linkedin(auth)
        current_user.save

        redirect_to root_url, notice: "Successfully linked that account!"
      end
    else
      if @identity.user.present?
        # The identity we found had a user associated with it so let's
        # just log them in here
        flash.notice = "Signed in!"
        sign_in_and_redirect @identity.user, notice: "Signed in!"
      else
        # No user associated with the identity so we need to create a new one
        user = User.new( 
            name: auth['info']['name'], 
            email: auth['info']['email'], 
            username: auth['info']['name'].parameterize,
            skills: fetch_skills_from_linkedin(auth)
        )
        user.identities << @identity
        
        user.skip_confirmation! 
        user.save
        
        sign_in_and_redirect user, notice: "Signed in!"
      end
    end
  end
  alias_method :linkedin, :all
  
private
  def fetch_skills_from_linkedin(auth)
    auth[:extra][:raw_info][:skills][:values].map{|e| e[:skill][:name]}.join(",")  
  end  
end
