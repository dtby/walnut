class ProjectCourse < ActiveRecord::Base
  belongs_to :project
  belongs_to :course
end
