class Photo < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  mount_uploader :photo, PhotoUploader
  
  attr_accessible :photo, :photo_cache
  
  belongs_to :place
  
  validates :photo, presence: true
  
  def photo_name
    self.photo.to_s.match(/[^\/]*$/).to_s
  end 
end
