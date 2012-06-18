class Place
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid

  mount_uploader :photo, PhotoUploader

  field :name
  field :desc
  field :website
  field :wifi
  field :transport
  field :price, type:  Integer
  field :address_line1
  field :address_line2
  field :city
  field :zipcode
  field :country
  field :reward
  field :public, type: Boolean, default: false
  field :smoke, type: Boolean, default: false
  field :music, type: Boolean, default: true
  field :discussion, type: Boolean, default: true

  field :coordinates, type: Array

  field :photo

  geocoded_by :address 

  belongs_to :user

  has_many :place_requests

  validates :name, length: { in: 5..45 }
  validates :desc, length: { in: 5..500 }, presence: true
  validates :address_line1, presence: true
  validates :city, presence: true
  validates :country, presence: true

  after_validation :geocode, if: lambda { |o| o.address_line1_changed? || o.city_changed? || o.country_changed? }
  after_save :become_cow, if: lambda { |o| o.user.places.count > 0}
  
  class << self
    def city(cities)
      if cities
        where(:city.in => cities)
      else
        all
      end
    end
  end

  def address
    [address_line1, city, country].join(', ')
  end

  def owned_by(user)
    self.user == user
  end

  has_many :comments

  private
  def become_cow
    self.user.is_cow = true
    self.user.save
  end
end
