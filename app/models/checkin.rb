class Checkin < ActiveRecord::Base
  attr_accessible :place_id, :status, :user_id

  belongs_to :user
  belongs_to :place, counter_cache: true

  symbolize :status, in: [:works, :worked], scopes: :true, methods: true

  validates :place_id, uniqueness: { scope: :user_id }

end
