class CreateStageCourses < ActiveRecord::Migration
  def change
    create_table :stage_courses do |t|
      t.references :course, index: true, foreign_key: true
      t.references :stage_courseable, polymorphic: true

      t.timestamps null: false
    end
  end
end
