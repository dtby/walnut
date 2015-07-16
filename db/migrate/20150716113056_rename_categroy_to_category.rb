class RenameCategroyToCategory < ActiveRecord::Migration
  def change
  	rename_table('categroys', 'categories')
  end
end
