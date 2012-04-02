class Place
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid

  mount_uploader :photo, PhotoUploader

  field :name
  field :desc
  field :wifi
  field :transport
  field :price, type:  Integer
  field :address_line1
  field :address_line2
  field :city
  field :zipcode
  field :country

  field :coordinates, type: Array

  field :photo

  geocoded_by :address 

  belongs_to :user

  after_validation :geocode, if: :address_line1_changed?

  def address
    [address_line1, 'Paris', 'France'].join(', ')
  end
end
