class CreateTaskCategories < ActiveRecord::Migration
  def change
    create_table :task_categories do |t|
      t.references :project, index: true
      t.string :name
      t.string :description
      t.integer :unfinished, default: 0
      t.integer :total, default: 0

      t.timestamps null: false
    end
  end
end
