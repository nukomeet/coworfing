# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Coworfing::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.mandrillapp.com",
  :port                 => 587,
  :user_name            => ENV["MANDRILL_USERNAME"],
  :password             => ENV["MANDRILL_API_KEY"],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
