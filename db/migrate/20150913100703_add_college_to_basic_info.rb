class AddCollegeToBasicInfo < ActiveRecord::Migration
  def change
    add_column :basic_infos, :college, :string
  end
end
