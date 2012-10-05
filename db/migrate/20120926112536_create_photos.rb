class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.integer :place_id
      t.string :photo

      t.timestamps
    end
        
    Place.where("photo IS NOT NULL").all.each{ |place|
      if File.exists?(place.photo)
        photo = place.photos.build() 
        photo.write_uploader(:photo, place.photo)
        photo.save!
      end
    }
    
    remove_column :places, :photo
  end  
  
  def down
    add_column :places, :photo, :string
    drop_table :photos
  end
end
