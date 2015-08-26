class AddNameToApplies < ActiveRecord::Migration
  def change
    add_column :applies, :name, :string
    add_column :applies, :school_name, :string
  end
end
