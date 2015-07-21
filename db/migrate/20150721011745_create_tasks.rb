class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :project, index: true
      t.references :task_category, index: true
      t.integer :No
      t.string :name
      t.string :description
      t.date :end_time
      t.integer :level
      t.integer :state

      t.timestamps null: false
    end
  end
end
