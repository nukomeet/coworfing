class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.text :desc
      t.string :website
      t.string :wifi
      t.string :transport
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :zipcode
      t.string :country

      t.timestamps
    end
  end
end
