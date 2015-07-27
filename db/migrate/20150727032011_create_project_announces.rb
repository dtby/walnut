class CreateProjectAnnounces < ActiveRecord::Migration
  def change
    create_table :project_announces do |t|
      t.references :project, index: true, foreign_key: true
      t.references :announce, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
