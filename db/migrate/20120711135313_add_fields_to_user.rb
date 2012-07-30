class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    add_column :users, :username, :string
    add_column :users, :bio, :text
    add_column :users, :website, :string
    add_column :users, :twitter, :string
  end
end
