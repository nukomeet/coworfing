class User < ActiveRecord::Base
  before_save :log_user
  after_save :log_user
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :name, :email, :public_email, :password, :password_confirmation, :remember_me, :confirmed_at, :username, :bio, :website, :twitter, :public, :skills

  ROLES = %w(admin regular guest)

  validates_presence_of :email
  validates_uniqueness_of :name, :email, :username, case_sensitive: false

  validates :username, format: { with: /\A[\w-]+\Z/i, message: "must contain only numbers, letters and - , _ characters" }, length: { in: 2..20 }, presence: true, uniqueness: true
  validates :twitter,  format: { with: /\A\w+\Z/i }, allow_nil: true, allow_blank: true

  validate :username_is_unique_with_organization_name

  has_many :places, as: :owner
  has_many :invitations, class_name: 'User', as:  :invited_by

  has_many :place_requests_received, class_name: 'PlaceRequest', foreign_key: 'receiver_id'
  has_many :place_requests_sent, class_name: 'PlaceRequest', foreign_key: 'booker_id'
  has_many :comments

  has_many :identities

  has_many :memberships
  has_many :organizations, through: :memberships
  has_many :admin_organizations,
    class_name: Organization,
    source: :organization,
    through: :memberships,
    conditions: { "memberships.role" => "admin" }
  has_many :regular_organizations,
    class_name: Organization,
    source: :organization,
    through: :memberships,
    conditions: { "memberships.role" => "regular" }

  has_many :checkins
  has_many :checkin_places, through: :checkins, class_name: "Place", source: :place

  scope :with_username, where("username is not null")

  scope :by_username, lambda { |username| where('username ILIKE ?', username) }



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

  def gravatar?
    Rails.cache.fetch(self.email, expires_in: 1.days) do
      ask_gravatar(self.email)
    end
  end

  def invitation_accepted?
    self.invitation_accepted_at? or self.username or !self.regular?
  end

  def self.valid_attribute?(attr, params)
    mock = self.new( params )
    unless mock.valid?
      return ! mock.errors.has_key?(attr)
    end
    #true
  end

  def provider?(provider)
    ! identities.select {|ident| ident.provider == provider.to_s }.empty?
  end

  def password_required?
    super && identities.empty?
  end

  def username_is_unique_with_organization_name
    unless Organization.by_name(self.username).empty?
      errors.add(:username, 'username is already taken')
    end
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
  private

  def ask_gravatar(email)
    hash = Digest::MD5.hexdigest(email.to_s.downcase)
    http = Net::HTTP.new('gravatar.com', 80)
    http.read_timeout = 2
    response = http.request_head("/avatar/#{hash}?d=404")
    response.code != '404'
  rescue StandardError, Timeout::Error
    true  # when the website is down, return true
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def log_user
    Rails.logger.info self.inspect
  end
end
