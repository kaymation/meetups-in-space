class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |table|
      table.string :content, null: false
      table.integer :user_id, null: false
      table.integer :meetup_id, null: false
    end
  end
end
