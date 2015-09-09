class CreateTechnologyStages < ActiveRecord::Migration
  def change
    create_table :technology_stages do |t|
      t.string :name
      t.text :discribe
      t.references :technology, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
