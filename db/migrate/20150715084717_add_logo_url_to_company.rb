class AddLogoUrlToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :logo_url, :string
  end
end
