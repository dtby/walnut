class RenameStudentToApply < ActiveRecord::Migration
  def change
  	rename_table :students, :applies
  end
end
