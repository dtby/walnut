class DropProjectAnnounces < ActiveRecord::Migration
  def change
  	drop_table :project_announces
  end
end
