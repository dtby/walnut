class AddViewCountToInterview < ActiveRecord::Migration
  def change
    add_column :interviews, :view_count, :integer
  end
end
