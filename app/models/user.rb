class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at, :username, :bio, :website, :twitter, :public
  #attr_accessible :confirmation_sent_at, :confirmation_token, :created_at, :current_sign_in_at, :current_sign_in_ip, :encrypted_password, :last_sign_in_at, :last_sign_in_ip, :photo, :remember_created_at, :role, :sign_in_count, :updated_at, :invitation_accepted_at, :invitation_sent_at, :invitation_token, :invited_by_id, :invited_by_type, :reset_password_sent_at, :reset_password_token

  mount_uploader :photo, PhotoUploader

  ROLES = %w(admin regular guest)

  validates_presence_of :email
  validates_uniqueness_of :name, :email, :username, case_sensitive: false

  validates :username, format: { with: /\A\w+\Z/i }, length: { in: 2..12 }, presence: true, uniqueness: true

  has_many :places
  has_many :invitations, class_name: 'User', as:  :invited_by

  has_many :place_requests_received, class_name: 'PlaceRequest'
  has_many :place_requests_sent, class_name: 'PlaceRequest'
  has_many :comments

  # defining roles 
  def admin?
    self.role == "admin"
  end

  def regular?
    self.role == "regular"
  end

  def guest?
    self.role == "guest"
  end
  
end
