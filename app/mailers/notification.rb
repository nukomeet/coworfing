class Notification < ActionMailer::Base
  default from: "bonjour@nukomeet.com"

  def notification_request(user)
    mail to: user.email, subject: "Coworfing Request"
  end
end

