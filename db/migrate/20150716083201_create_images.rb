class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps null: false
    end
  end
end
