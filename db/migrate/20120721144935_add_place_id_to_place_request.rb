class AddPlaceIdToPlaceRequest < ActiveRecord::Migration
  def change
    add_column :place_requests, :place_id, :integer
    add_column :place_requests, :booker_id, :integer
    add_column :place_requests, :receiver_id, :integer
  end
end
