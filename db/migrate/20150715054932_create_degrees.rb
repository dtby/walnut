class CreateDegrees < ActiveRecord::Migration
  def change
    create_table :degrees do |t|
      t.string :name
      t.integer :sort_no, default: 1000

      t.timestamps null: false
    end
  end
end
