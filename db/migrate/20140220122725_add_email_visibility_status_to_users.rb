class AddEmailVisibilityStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :public_email, :string
  end
end
