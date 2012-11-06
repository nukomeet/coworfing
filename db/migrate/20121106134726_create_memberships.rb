class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :organization_id
      t.string :role, default: 'regular'

      t.timestamps
    end
  end
end
