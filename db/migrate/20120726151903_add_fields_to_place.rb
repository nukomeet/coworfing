class AddFieldsToPlace < ActiveRecord::Migration
  def change
    add_column :places, :kind, :string
    add_column :places, :features, :integer
  end
end
