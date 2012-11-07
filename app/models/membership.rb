class Membership < ActiveRecord::Base
  attr_accessible :organization_id, :role, :user_id

  symbolize :role, in: [:admin, :regular], scopes: true, methods: true

  belongs_to :organization
  belongs_to :user
end
