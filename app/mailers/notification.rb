class Notification < ActionMailer::Base
  default from: "bonjour@nukomeet.com"

  def request_notification_email(user)
    @place_request.receiver = user
    mail to: user.email, subject: "Coworfing Request Pending"
  end
end

