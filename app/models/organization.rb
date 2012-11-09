class Organization < ActiveRecord::Base
  attr_accessible :gravatar_email, :name, :website

  has_many :memberships
  has_many :users, through: :memberships
  has_many :places, as: :owner

  validates :name, length: { in: 5..45 }, presence: true, uniqueness: { case_sensitive: false }
  validates :gravatar_email, presence: true

  validate :name_is_unique_with_user_username

  alias_attribute :username, :name

  scope :by_name, lambda { |name| where('name ILIKE ?', name) }

  def admins
    memberships.where(role: :admin).map(&:user)
  end

  def regulars
    memberships.where(role: :regular).map(&:user)
  end

  def email
    admins.map(&:email)
  end

  def name_is_unique_with_user_username
    unless User.by_username(self.username).empty?
      errors.add(:name, 'username is already taken')
    end
  end

end
