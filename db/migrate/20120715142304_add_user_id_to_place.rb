class AddUserIdToPlace < ActiveRecord::Migration
  def change
    add_column :places, :user_id, :integer
  end
end
