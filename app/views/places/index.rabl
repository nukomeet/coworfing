collection @places_all

attributes :id, :name, :desc, :longitude, :latitude, :address_line1, :city, :country

node :coordinates do |p|
  [p.longitude, p.latitude]
end

node :_id do |p|
  p.id
end

node(:photo) do |p| 
	{:url => nil, :petit => {:url => nil } }
	unless p.photos.empty?
		{:url => p.photos.first.photo.url, :petit => {:url => p.photos.first.photo.small.url}  }
	end
end
