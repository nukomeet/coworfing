# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'Empty the MongoDB database'
Mongoid.master.collections.reject { |c| c.name =~ /^system/ }.each(&:drop)

puts 'Setting up users'
user = User.create! :name => 'Alban LV', :email => 'albanlv@gmail.com', :password => 'please', :password_confirmation => 'please', :role => 'admin', :username => 'albanlv'
user.skip_confirmation!
user.save
puts 'New user created: ' << user.name

user = User.create! :name => 'Zaiste!', :email => 'oh@zaiste.net', :password => 'please', :password_confirmation => 'please', :role => 'admin', :username => 'zaiste'
user.skip_confirmation!
user.save
puts 'New user created: ' << user.name

user = User.create! :name => 'admin', :email => 'admin@gmail.com', :password => 'myadmin', :password_confirmation => 'myadmin', :role => 'admin', :username => 'admin'
user.skip_confirmation!
user.save
puts 'New user created: ' << user.name

puts 'Setting up places'
i = 0

while (i <= 10)
	place = Place.create! :name=>"place" + i.to_s, :desc=>'qqqqq', :wifi=>'', :transport=>'', :price=>'', 
	:address_line1=>'', :address_line2=>'', :city=>'', :zipcode=>'', :country=>'', :reward=>'', 
	:public=>'', :smoke=>'', :music=>'', :discussion=>'', :coordinates=>[45.525277 + i, -73.604043 + i], :photo=>''
	place.save
	puts 'New place created: ' << place.name

	i += 1
end




