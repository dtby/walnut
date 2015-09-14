class CreateEduExperiences < ActiveRecord::Migration
  def change
    create_table :edu_experiences do |t|
      t.string :school
      t.string :time
      t.string :major
      t.string :education

      t.timestamps null: false
    end
  end
end
