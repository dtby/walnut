class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :web_address
      t.string :contact_phone
      t.string :contact

      t.timestamps null: false
    end
  end
end
