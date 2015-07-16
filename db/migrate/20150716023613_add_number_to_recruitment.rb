class AddNumberToRecruitment < ActiveRecord::Migration
  def change
    add_column :recruitments, :number, :integer
  end
end
