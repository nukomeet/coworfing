class AddDefaultValueToUserRole < ActiveRecord::Migration
  def up
      change_column :users, :role, :string, :default => "regular"
  end

  def down
      change_column :users, :role, :string, :default => nil
  end
end
