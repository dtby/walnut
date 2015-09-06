class CreateTrains < ActiveRecord::Migration
  def change
    create_table :trains do |t|
      t.string :title
      t.integer :pv
      t.text :introduce
      t.text :syllabus
      t.text :prospect
      t.text :characteristic
      t.string :picture_url
      t.text :content
      t.string :picture_url

      t.timestamps null: false
    end
  end
end
