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
        redirect_to root_url, notice: "Already linked that account!"
      else
        # The identity is not associated with the current_user so lets
        # associate the identity
        token = auth["extra"]["access_token"].token
        secret = auth["extra"]["access_token"].secret

        client = LinkedIn::Client.new(ENV['LINKEDIN_CONSUMER_KEY'], ENV['LINKEDIN_CONSUMER_SECRET'])
        client.authorize_from_access(token, secret)

        skills = []
        client.profile(fields: ['skills'])['skills']['all'].each do |s|
          skills << s['skill']['name']
        end

        @identity.user = current_user
        @identity.save

        # Migrate date
        current_user.skills = skills.join(',')
        current_user.save

        redirect_to root_url, notice: "Successfully linked that account!"
      end
    else
      if @identity.user.present?
        # The identity we found had a user associated with it so let's
        # just log them in here
        flash.notice = "Signed in!"
        sign_in_and_redirect @identity.user, notice: "Signed in!"
        redirect_to root_url, notice: "Signed in!"
      else
        # No user associated with the identity so we need to create a new one
        user = User.create(name: auth['info']['name'], email: auth['info']['email'])
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_url, notice: "Please finish registering"
      end
    end
  end
  alias_method :linkedin, :all
end
