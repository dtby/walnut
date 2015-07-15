class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.string :title
      t.string :content
      t.references :iv_category, index: true, foreign_key: true
      t.integer :browse_count, default: 0

      t.timestamps null: false
    end
  end
end
