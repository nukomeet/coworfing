class AddOwnerAttrToPlace < ActiveRecord::Migration
  def change
    add_column :places, :owner_id, :integer
    add_column :places, :owner_type, :string
  end
end
