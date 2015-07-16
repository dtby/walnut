class CreateTeacherCourses < ActiveRecord::Migration
  def change
    create_table :teacher_courses do |t|
      t.references :teacher, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
