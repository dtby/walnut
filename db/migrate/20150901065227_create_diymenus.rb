class CreateDiymenus < ActiveRecord::Migration
  def change
    create_table :diymenus do |t|
      t.integer :parent_id
      t.string :name
      t.string :key
      t.string :url
      t.boolean :is_show
      t.integer :sort

      t.timestamps null: false
    end
    add_index :diymenus, :parent_id
    add_index :diymenus, :key
  end
end
