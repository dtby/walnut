class AddNameToBasicInfo < ActiveRecord::Migration
  def change
    add_column :basic_infos, :name, :string
  end
end
