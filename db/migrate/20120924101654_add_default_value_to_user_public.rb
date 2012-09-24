class AddDefaultValueToUserPublic < ActiveRecord::Migration
  def up
      change_column :users, :public, :boolean, :null => false, :default => false
  end

  def down
      change_column :users, :public, :boolean
  end
end
