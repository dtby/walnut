class RenameCategroyToCategory < ActiveRecord::Migration
  def change
  	rename_table('categorys', 'categories')
  end
end
