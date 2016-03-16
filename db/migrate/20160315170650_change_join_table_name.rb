class ChangeJoinTableName < ActiveRecord::Migration
  def change
    rename_table :meetups_users, :meetup_users
  end
end
