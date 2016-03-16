class ChangeMeetupDateToString < ActiveRecord::Migration
  def change
    change_column :meetups, :when, :string
  end
end
