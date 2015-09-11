class TechnologyStage < ActiveRecord::Base
  belongs_to :technology

  has_many :stage_courses, as: :stage_courseable, dependent: :destroy
  has_many :courses, through: :stage_courses
end
