# == Schema Information
#
# Table name: project_courses
#
#  id         :integer          not null, primary key
#  project_id :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProjectCourse < ActiveRecord::Base
  belongs_to :project
  belongs_to :course
end
