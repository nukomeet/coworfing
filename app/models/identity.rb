class Identity < ActiveRecord::Base
  attr_accessible :provider, :uid

  belongs_to :user

  validates :user, :provider, :uid, presence: true

  def self.find_with_omniauth(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid'])
  end

  def self.create_with_omniauth(auth)
    create(uid: auth['uid'], provider: auth['provider'])
  end
end
