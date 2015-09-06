class RemoveAddressFromApplies < ActiveRecord::Migration
  def change
    remove_column :applies, :address, :string
  end
end
