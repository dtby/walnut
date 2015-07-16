class AddRefToTables < ActiveRecord::Migration
  def change
  	add_reference(:courses, :teacher)
  	add_reference(:courses, :college)
  	add_reference(:courses, :category)
  	add_reference(:sub_courses, :course)
  	add_reference(:attachments, :sub_course)
  end
end