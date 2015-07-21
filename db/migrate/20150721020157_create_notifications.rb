class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :project, index: true
      t.text :content

      t.timestamps null: false
    end
  end
end
