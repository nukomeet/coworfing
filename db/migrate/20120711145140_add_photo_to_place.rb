class AddPhotoToPlace < ActiveRecord::Migration
  def change
    add_column :places, :photo, :string
  end
end
