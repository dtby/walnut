class RemovePvFromTrains < ActiveRecord::Migration
  def change
  	remove_column :trains, :pv
  end
end
