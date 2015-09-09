class CreateProfessionStages < ActiveRecord::Migration
  def change
    create_table :profession_stages do |t|
      t.string :name
      t.text :discribe
      t.references :profession, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
