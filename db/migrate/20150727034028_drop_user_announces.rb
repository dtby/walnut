class DropUserAnnounces < ActiveRecord::Migration
  def change
  	drop_table :user_announces
  end
end
