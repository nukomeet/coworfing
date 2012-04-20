class Notification < ActionMailer::Base
  def notification_request(user)
    mail(:to => user, :subject => "Coworfing Request", :from => "bonjour@nukomeet.com")
  end
end

