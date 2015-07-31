class ChangeOthersOnRecruitment < ActiveRecord::Migration
  def change
    change_column :recruitments, :others, :text
  end
end
