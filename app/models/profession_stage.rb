class ProfessionStage < ActiveRecord::Base
	validates :name, :discribe, presence: true
	
	belongs_to :profession

	has_many :stage_courses, as: :stage_courseable, dependent: :destroy
	has_many :courses, through: :stage_courses
end
