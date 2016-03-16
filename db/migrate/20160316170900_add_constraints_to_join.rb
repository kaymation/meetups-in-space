class AddConstraintsToJoin < ActiveRecord::Migration
  def up
    change_column :meetup_users, :owner, :boolean, null: false, default: false
  end

  def down
    change_column :meetup_users, :owner, :boolean
  end
end
