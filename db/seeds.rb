# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'Empty the MongoDB database'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

puts 'Setting up userx '
user = User.create! :name => 'Alban LV', :email => 'albanlv@example.com', :password => 'please', :password_confirmation => 'please', :role => 'regular'
puts 'New user created: ' << user.name

user = User.create! :name => 'Zaiste DG', :email => 'zaiste@example.com', :password => 'please', :password_confirmation => 'please', :role => 'regular'
puts 'New user created: ' << user.name
