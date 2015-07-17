class Course < ActiveRecord::Base
	has_one :image, as: :imageable, dependent: :destroy
	has_one :attachment, as: :attachmentable, dependent: :destroy
	has_many :sub_courses, dependent: :destroy
	belongs_to :teacher
	belongs_to :category
	belongs_to :college

	def last_update_time
		self.sub_courses.present? ? self.sub_courses.last.updated_at : ""
	end
end
