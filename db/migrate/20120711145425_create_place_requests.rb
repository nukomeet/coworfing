class CreatePlaceRequests < ActiveRecord::Migration
  def change
    create_table :place_requests do |t|
      t.boolean :active
      t.datetime :requested_on
      t.text :body

      t.timestamps
    end
  end
end
