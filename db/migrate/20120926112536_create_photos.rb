class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.integer :place_id
      t.string :photo

      t.timestamps
    end
    
    if Rails.env.production?    
      Place.where("photo IS NOT NULL").all.each{ |place|
        photo = place.photos.build()
        photo_uri = URI.parse(place.photo.url) 
        photo.remote_photo_url = photo_uri.to_s
        photo.save!
      }
    end
    
    #remove_column :places, :photo
  end  
  
  def down
    #add_column :places, :photo, :string
    drop_table :photos
  end
end
