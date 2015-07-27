class DropProjectAnnounces < ActiveRecord::Migration
  def change
  	create_table :project_announces
  	drop_table :project_announces
  end
end
