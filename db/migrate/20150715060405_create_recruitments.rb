class CreateRecruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
      t.string :name
      t.string :gender
      t.string :certificate
      t.references :degree
      t.references :company
      t.string :category
      t.string :city
      t.string :remuneration
      t.string :foreign_language
      t.string :others
      t.text :description
      t.string :hr_email
      t.integer :browse_count, default: 0
      t.string :publish_time

      t.timestamps null: false
    end
  end
end
