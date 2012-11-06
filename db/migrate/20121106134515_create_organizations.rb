class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :gravatar_email

      t.timestamps
    end
  end
end
