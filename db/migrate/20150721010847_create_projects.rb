class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.boolean :is_public, default: true

      t.timestamps null: false
    end
  end
end
