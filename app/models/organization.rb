class Organization < ActiveRecord::Base
  attr_accessible :gravatar_email, :name

  has_many :memberships
  has_many :users, through: :memberships

  def admins
    memberships.where(role: :admin).map(&:user)
  end

  def regulars
    memberships.where(role: :regular).map(&:user)
  end

end
