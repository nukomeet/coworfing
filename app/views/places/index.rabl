collection @places_all

attributes :id, :name, :desc, :longitude, :latitude, :address_line1, :city, :country

node :coordinates do |p|
  [p.latitude, p.longitude]
end

node :_id do |p|
  p.id
end

#child(:photo => :photo) { attributes :url, :big }
node(:photo) { |p| {:url => p.photo.url, :petit => p.photo.small.url } }
