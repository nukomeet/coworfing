class RemoveDemands < ActiveRecord::Migration
  def up
    drop_table :demands
  end

  def down
    create_table :demands do |t|
      t.string :email

      t.timestamps
    end
  end
end
