class CreateIvCategories < ActiveRecord::Migration
  def change
    create_table :iv_categories do |t|
      t.string :name
      t.integer :sort_no, default: 1000

      t.timestamps null: false
    end
  end
end
