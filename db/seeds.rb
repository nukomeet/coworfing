# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'Empty the MongoDB database'
#Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

puts 'Setting up userz'
user = User.create! :name => 'Alban LV', :email => 'albanlv@gmail.com', :password => 'please', :password_confirmation => 'please', :role => 'admin', :confirmed_at => 1.day.ago, :confirmation_sent_at => 2.days.ago
puts 'New user created: ' << user.name

user = User.create! :name => 'Zaiste!', :email => 'oh@zaiste.net', :password => 'please', :password_confirmation => 'please', :role => 'admin', :confirmed_at => 1.day.ago, :confirmation_sent_at => 2.days.ago
puts 'New user created: ' << user.name
