class CreateProjectCourses < ActiveRecord::Migration
  def change
    create_table :project_courses do |t|
      t.references :project, index: true
      t.references :course, index: true

      t.timestamps null: false
    end
  end
end
