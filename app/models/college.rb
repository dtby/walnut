# == Schema Information
#
# Table name: colleges
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class College < ActiveRecord::Base
	has_one :image, as: :imageable, dependent: :destroy

	has_many :stage_courses, as: :stage_courseable, dependent: :destroy
	has_many :courses, through: :stage_courses
end
