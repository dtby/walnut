class AddColumnToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :city, :string
    add_column :companies, :industry, :string
    add_column :companies, :nature, :string
    add_column :companies, :scale, :string
  end
end
