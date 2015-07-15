class AddIndustryToRecruitment < ActiveRecord::Migration
  def change
    add_column :recruitments, :industry, :string
  end
end
