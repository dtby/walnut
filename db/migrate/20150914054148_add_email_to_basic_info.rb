class AddEmailToBasicInfo < ActiveRecord::Migration
  def change
    add_column :basic_infos, :email, :string
  end
end
