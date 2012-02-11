class Place
  include Mongoid::Document
  field :name, :type => String
  field :desc, :type => String
  field :price, :type => Integer
  field :address_line1, :type => String
  field :address_line2, :type => String
  field :city, :type => String
  field :zipcode, :type => String
  field :country, :type => String
end
