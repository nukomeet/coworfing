require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails' 
gem 'pg'
gem 'thin'

gem 'oj'

group :assets do
  gem 'sass-rails'
  gem "bootstrap-sass"
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'font-awesome-sass-rails'
  gem "therubyracer", platform: :ruby
end

group :development do
  gem 'taps', require: false
  gem 'sqlite3'
  gem "guard"
  gem "guard-bundler"
  gem "guard-rails"
  gem "guard-livereload"
  gem "guard-rspec"
  gem 'quiet_assets'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
  gem 'spork', '~> 0.9.0.rc'
  gem "database_cleaner"
  gem 'guard-spork', '0.3.2'
  gem 'shoulda'
  gem "email_spec"
end

gem 'jquery-rails'
gem 'jquery-ui-themes'
gem "haml", ">= 3.1.6"
gem "haml-rails", ">= 0.3.4", :group => :development
gem "rspec-rails", ">= 2.10.1", :group => [:development, :test]
gem "factory_girl_rails", ">= 3.3.0", :group => [:development, :test]
gem "hominid"
gem "devise"
gem "devise_invitable"
gem "cancan"
gem "simple_form"
gem 'mini_magick'
gem 'rabl'
gem 'yajl-ruby'
gem 'heroku'
gem 'fog'
gem 'symbolize', require: 'symbolize/active_record'
gem 'chosen-rails'
gem 'kaminari'
gem 'bootstrap_kaminari', git: 'git://github.com/dleavitt/bootstrap_kaminari.git'
gem 'hominid'
gem 'hipchat'
gem 'carrierwave'
gem 'geocoder'
gem 'bitmask_attributes'
gem 'country_select'
gem 'rb-readline'
