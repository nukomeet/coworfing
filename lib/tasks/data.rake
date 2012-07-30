require 'multi_json'
require 'pp'
require 'uri'

class String
  def to_bool
    return true if self == true || self =~ (/(true|t|yes|y|1)$/i)
    return false if self == false || self.blank? || self =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end


namespace :data do

  task :prepare do
    uri  = URI.parse(ENV['MONGOLAB_URI'])
  end
  
  desc "Import from JSON file"

  task :import => :environment do

    User.delete_all
    users = {}
    File.read(Rails.root.join('db/users.json')).each_line do |line|

      line.gsub!(/ObjectId\((.*?)\)/, '\1')
      line.gsub!(/Date\(\s(.*?)\s\)/, '"\1"')
      line.gsub!(/true/, '"true"')
      line.gsub!(/false/, '"false"')

      user = MultiJson.load(line)

      n_user = User.create(user.except("_id", "_type", "rank", "is_cow", "failed_attempts"))
      n_user.save(validate: false)

      users[user['_id']] = n_user.id 
    end

    Place.delete_all
    places = {}
    File.read(Rails.root.join('db/places.json')).each_line do |line|

      line.gsub!(/ObjectId\((.*?)\)/, '\1')
      line.gsub!(/Date\(\s(.*?)\s\)/, '"\1"')
      line.gsub!(/\[\s\*\]/, '')
      line.gsub!(/\[(.*?)\]/, '"\1"')
      line.gsub!(/true/, '"true"')
      line.gsub!(/false/, '"false"')

      place = MultiJson.load(line)

      n_place = Place.create(place.except("_id", "coordinates", "discussion", "music", "public", "smoke", "reward", "user_id"))

      # custom: lan & lat
      if place.has_key?('coordinates')
        lon, lat = place['coordinates'].split(",") 
        n_place.latitude = lat
        n_place.longitude = lon
      end

      if place.has_key?('photo')
        n_place.photo = place['photo']
      end

      # custom: feature 
      if place['discussion'].to_bool 
        n_place.features << :discussion
      elsif place['music'].to_bool 
        n_place.features << :music
      elsif place['smoke'].to_bool 
        n_place.features << :smoke
      end

      if place['public'].to_bool
        n_place.kind = :public
      else
        n_place.kind = :private
      end

      n_place.created_at = DateTime.strptime(place['created_at'], '%Q')
      n_place.updated_at = DateTime.strptime(place['updated_at'], '%Q')

      # assign user_id
      n_place.user_id = users[place['user_id']] 

      n_place.save

      places[place['_id']] = n_place.id 
    end

    PlaceRequest.delete_all
    place_requests = {}

    File.read(Rails.root.join('db/place_requests.json')).each_line do |line|

      line.gsub!(/ObjectId\((.*?)\)/, '\1')
      line.gsub!(/Date\(\s(.*?)\s\)/, '"\1"')
      line.gsub!(/true/, '"true"')
      line.gsub!(/false/, '"false"')

      place_request = MultiJson.load(line)

      n_place_request = PlaceRequest.create(place_request.except("_id", "place_id", "booker_id", "receiver_id", "date", "status"))
      n_place_request.place_id = places[place_request['place_id']]
      n_place_request.booker_id = users[place_request['booker_id']]
      n_place_request.receiver_id = users[place_request['receiver_id']]

      n_place_request.created_at = DateTime.strptime(place_request['created_at'], '%Q')
      n_place_request.updated_at = DateTime.strptime(place_request['updated_at'], '%Q')
      n_place_request.requested_on = DateTime.strptime(place_request['date'], '%Q')
      n_place_request.status = place_request['status'] 

      n_place_request.save

      place_requests[place_request['id']] = n_place_request.id
    end

    Comment.delete_all
    comments = {}
    File.read(Rails.root.join('db/comments.json')).each_line do |line|

      line.gsub!(/ObjectId\((.*?)\)/, '\1')
      line.gsub!(/Date\(\s(.*?)\s\)/, '"\1"')
      line.gsub!(/true/, '"true"')
      line.gsub!(/false/, '"false"')

      comment = MultiJson.load(line)

      n_comment = Comment.create(comment.except("_id", "place_id", "user_id"))
      n_comment.place_id = places[comment['place_id']]
      n_comment.user_id = users[comment['user_id']]

      n_comment.save
    end

  end
end