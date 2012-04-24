class Notification < ActionMailer::Base
  default from: "bonjour@nukomeet.com"

  def request_notification_email(user)
    mail to: user.email, subject: "Coworfing Request Pending"
  end

  def request_confirmation_email(user)
    mail to: user.email, subject: "Your coworfing request has been accepted"
  end
end

