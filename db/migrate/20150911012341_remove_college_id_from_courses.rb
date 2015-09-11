class RemoveCollegeIdFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :college_id, :integer
  end
end
