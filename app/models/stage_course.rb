class StageCourse < ActiveRecord::Base
  belongs_to :course
  belongs_to :stage_courseable,  polymorphic: true
end
