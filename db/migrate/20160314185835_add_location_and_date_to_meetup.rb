class AddLocationAndDateToMeetup < ActiveRecord::Migration
  def change
    add_column :meetups, :location, :string
    add_column :meetups, :when, :datetime
  end
end
