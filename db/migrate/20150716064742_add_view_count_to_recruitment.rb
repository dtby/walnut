class AddViewCountToRecruitment < ActiveRecord::Migration
  def change
    add_column :recruitments, :view_count, :integer
  end
end
