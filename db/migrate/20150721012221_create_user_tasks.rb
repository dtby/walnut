class CreateUserTasks < ActiveRecord::Migration
  def change
    create_table :user_tasks do |t|
      t.references :user, index: true
      t.references :task, index: true
      t.integer :role

      t.timestamps null: false
    end
  end
end
