class ChangeTypeOfInvitationTokenInUsersToText < ActiveRecord::Migration
  def up
    change_column :users, :invitation_token, :text
  end

  def down
    change_column :users, :invitation_token, :string
  end
end
