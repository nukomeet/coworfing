class AddCheckinsCountToPlaces < ActiveRecord::Migration
  def up
    add_column :places, :checkins_count, :integer, default: 0

    Place.all.each do |p|
      Place.update_counters(p.id, checkins_count: p.checkins.length)
    end
  end

  def down
    remove_column :places, :checkins_count
  end
end
