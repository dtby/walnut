class CreateAnnounces < ActiveRecord::Migration
  def change
    create_table :announces do |t|
      t.string :title
      t.text :description
      t.references :project, index: true

      t.timestamps null: false
    end
  end
end
