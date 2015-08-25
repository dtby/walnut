class CreateStudentsPractices < ActiveRecord::Migration
  def change
    create_table :students_practices do |t|
      t.references :student, index: true, foreign_key: true
      t.references :practice, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
