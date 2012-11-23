class Checkin < ActiveRecord::Base
  attr_accessible :place_id, :status, :user_id

  belongs_to :user
  belongs_to :place

  symbolize :status, in: [:works, :worked], scopes: :true, methods: true

  validates :place_id, uniqueness: { scope: :user_id }

end
