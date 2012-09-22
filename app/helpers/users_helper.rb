module UsersHelper

  def twitter_url(user)
    "http://twitter.com/#{user.twitter}"
  end
end
