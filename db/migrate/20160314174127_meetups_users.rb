class MeetupsUsers < ActiveRecord::Migration
  def change
    create_table :meetups_users do |table|
      table.integer :meetup_id, null: false
      table.integer :user_id, null: false
      table.boolean :owner, default: false
    end
  end
end
