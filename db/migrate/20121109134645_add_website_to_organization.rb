class AddWebsiteToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :website, :string
  end
end
