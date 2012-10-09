class Place < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  
  acts_as_taggable
  attr_accessible :address_line1, :address_line2, :city, :country, :desc, :name, :transport, :website, :wifi, :zipcode, :kind, :features, :photos_attributes, :tag_list

  geocoded_by :address 

  # only add at the end
  bitmask :features, as: [:discussion, :music, :smoke]
  symbolize :kind, in: [:private, :public, :business], scopes: true, methods: true

  belongs_to :user

  has_many :place_requests
  has_many :comments
  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => Proc.new { |p| p[:photo].blank? && p[:photo_cache].blank? }
  
  delegate :name, :username, to: :user, allow_nil: true, prefix: true

  validates :name, length: { in: 5..45 }
  validates :desc, length: { in: 5..500 }, presence: true
  validates :address_line1, presence: true
  validates :city, presence: true, format: { with: /\A[a-zA-Z]+[\s\D]+[a-zA-Z]+\z/i }
  validates :country, presence: true

  after_validation :geocode, if: lambda { |o| o.address_line1_changed? || o.city_changed? || o.country_changed? }

  after_create :post_to_facebook, if: lambda { |p| p.public? || p.business? }

  class << self
    def location(location=[])
      unless location.blank?
        loc = location.is_a?(Array) ? location[0] : location
        geo = Geocoder.search(loc.gsub("-", " "))[0]
        if geo
          box = [
                  geo.geometry["bounds"]["southwest"]["lat"],
                  geo.geometry["bounds"]["southwest"]["lng"], 
                  geo.geometry["bounds"]["northeast"]["lat"],
                  geo.geometry["bounds"]["northeast"]["lng"], 
                ]
          within_bounding_box(box)
        end
      else
        scoped
      end
    end
  end

  def address
    [address_line1, city, country].join(', ')
  end
  
  def post_to_facebook
    if ENV['FB_ACCESS_TOKEN'] 
      page = Koala::Facebook::API.new(ENV['FB_ACCESS_TOKEN'])
      page.put_object('Coworfing', 'feed', message: 'A new place has been added', link: "https://coworfing.com/places/#{self.id}") 
    end
  end
end
