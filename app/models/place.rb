class Place < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  attr_accessible :address_line1, :address_line2, :city, :country, :desc, :name, :transport, :website, :wifi, :zipcode, :kind, :features, :photo

  geocoded_by :address 

  # only add at the end
  bitmask :features, as: [:discussion, :music, :smoke]
  symbolize :kind, in: [:private, :public, :business], scopes: true, methods: true

  belongs_to :user

  has_many :place_requests
  has_many :comments

  validates :name, length: { in: 5..45 }
  validates :desc, length: { in: 5..500 }, presence: true
  validates :address_line1, presence: true
  validates :city, presence: true
  validates :country, presence: true

  after_validation :geocode, if: lambda { |o| o.address_line1_changed? || o.city_changed? || o.country_changed? }

  class << self
    def city(cities=nil)
      unless cities.blank?
        where(city: cities)
      else
        self 
      end
    end
  end

  def address
    [address_line1, city, country].join(', ')
  end
end
