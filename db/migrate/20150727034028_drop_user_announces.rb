class DropUserAnnounces < ActiveRecord::Migration
  def change
  	create_table :user_announces
  	drop_table :user_announces
  end
end
