class CreateProjectsExps < ActiveRecord::Migration
  def change
    create_table :projects_exps do |t|
      t.string :title
      t.string :time
      t.string :role
      t.string :certificate
      t.string :custom

      t.timestamps null: false
    end
  end
end
