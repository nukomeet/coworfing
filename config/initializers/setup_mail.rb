require "development_mail_interceptor"

ActionMailer::Base.default_url_options[:host] = "www.coworfing.com"
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
