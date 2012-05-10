class Notification < ActionMailer::Base
  default from: "bonjour@nukomeet.com"

  def request_notification_email(user)
    mail to: user.email, subject: "Coworfing Request Pending"
  end

  def request_confirmation_email(user)
    mail to: user.email, subject: "Your coworfing request has been accepted"
  end

  def comment_email(user)
    mail to: user.email, subject: "There is a new comment on your place"
  end

  def become_cow_email(user)
    mail to: user.email, subject: "Congratulations, you just reached the Cow status!"
  end
end

