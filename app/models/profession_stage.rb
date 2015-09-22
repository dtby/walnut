class ProfessionStage < ActiveRecord::Base
	validates :name, :description, presence: true
	
	belongs_to :profession

	has_many :stage_courses, as: :stage_courseable, dependent: :destroy
	has_many :courses, through: :stage_courses
end
