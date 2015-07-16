class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.text :description
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
