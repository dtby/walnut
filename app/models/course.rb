# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  view_count  :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  teacher_id  :integer
#  college_id  :integer
#  category_id :integer
#

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
