# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Coworfing::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => ENV['SENDER_EMAIL'],
  :password             => ENV['SENDER_PASS'],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
