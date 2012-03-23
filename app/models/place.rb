class Place
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  field :name
  field :desc
  field :price, type:  Integer
  field :address_line1
  field :address_line2
  field :city
  field :zipcode
  field :country

  field :coordinates, type: Array

  geocoded_by :address 

  belongs_to :user

  after_validation :geocode, if: :address_line1_changed?

  def address
    [address_line1, 'Paris', 'France'].join(', ')
  end
end
