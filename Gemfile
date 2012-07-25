require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails' 
gem 'pg'
gem 'oj'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'font-awesome-sass-rails'
end
gem 'jquery-rails'
gem 'jquery-ui-themes'
gem "haml", ">= 3.1.6"
gem "haml-rails", ">= 0.3.4", :group => :development
gem "rspec-rails", ">= 2.10.1", :group => [:development, :test]
gem "factory_girl_rails", ">= 3.3.0", :group => [:development, :test]
gem "email_spec", ">= 1.2.1", :group => :test
gem "guard", ">= 0.6.2", :group => :development  
case HOST_OS
  when /darwin/i
    gem 'rb-fsevent', :group => :development
    gem 'growl', :group => :development
  when /linux/i
    gem 'libnotify', :group => :development
    gem 'rb-inotify', :group => :development
  when /mswin|windows/i
    gem 'rb-fchange', :group => :development
    gem 'win32console', :group => :development
    gem 'rb-notifu', :group => :development
end
gem "guard-bundler", ">= 0.1.3", :group => :development
gem "guard-rails", ">= 0.0.3", :group => :development
gem "guard-livereload", ">= 0.3.0", :group => :development
gem "guard-rspec", ">= 0.4.3", :group => :development
gem "hominid"
gem "devise", ">= 2.1.0"
gem "devise_invitable", ">= 1.0.2"
gem "cancan", ">= 1.6.7"
gem "rolify", ">= 3.1.0"
gem "bootstrap-sass", ">= 2.0.3"
gem "simple_form"
gem "therubyracer", :group => :assets, :platform => :ruby
gem 'mini_magick'
gem 'rabl'
gem 'yajl-ruby'
gem 'heroku'
gem 'fog'
gem "symbolize", :require => "symbolize/active_record"
gem 'chosen-rails'
gem 'kaminari'
gem 'bootstrap_kaminari', :git => 'git://github.com/dleavitt/bootstrap_kaminari.git'
gem 'hominid'
gem 'hipchat'
gem 'carrierwave'
gem 'geocoder'
gem 'bitmask_attributes'
gem 'country_select'