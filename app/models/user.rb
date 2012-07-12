class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at, :username, :bio, :website, :twitter, :public

  mount_uploader :photo, PhotoUploader

  validates_presence_of :email
  validates_uniqueness_of :name, :email, :username, case_sensitive: false

  validates :username, format: { with: /\A\w+\Z/i }, length: { in: 2..12 }, presence: true, uniqueness: true

  has_many :places
  has_many :invitations, class_name: 'User', as:  :invited_by
  has_many :place_requests_received, class_name: 'PlaceRequest', inverse_of: :receiver
  has_many :place_requests_sent, class_name: 'PlaceRequest', inverse_of: :booker
  has_many :comments

  # defining roles 
  def admin?
    self.has_role? "admin"
  end

  def regular?
    self.has_role? "regular"
  end

  def guest?
    self.has_role? "guest"
  end
  
end
