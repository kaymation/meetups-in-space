class AddConstraintsToMeetups < ActiveRecord::Migration
  def up
    change_column :meetups, :location, :string, null: false
    change_column :meetups, :when, :string, null: false
  end

  def down
    change_column :meetups, :location
    change_column :meetups, :when
  end
end
