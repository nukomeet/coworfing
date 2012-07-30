class AddPlaceIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :place_id, :integer
    add_column :comments, :user_id, :integer
  end
end
