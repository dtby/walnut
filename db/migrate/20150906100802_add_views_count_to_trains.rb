class AddViewsCountToTrains < ActiveRecord::Migration
  def change
    add_column :trains, :views_count, :integer
  end
end
