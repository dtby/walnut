class RenamecategoryToCategory < ActiveRecord::Migration
  def change
  	rename_table('categorys', 'categories')
  end
end
