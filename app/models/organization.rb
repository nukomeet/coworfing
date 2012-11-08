class Organization < ActiveRecord::Base
  attr_accessible :gravatar_email, :name

  has_many :memberships
  has_many :users, through: :memberships

  validates :name, length: { in: 5..45 }, presence: true
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

end
