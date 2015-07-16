class CreateSubCourses < ActiveRecord::Migration
  def change
    create_table :sub_courses do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
