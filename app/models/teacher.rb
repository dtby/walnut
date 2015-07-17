# == Schema Information
#
# Table name: teachers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Teacher < ActiveRecord::Base
	has_one :image, as: :imageable, dependent: :destroy
	has_many :courses, dependent: :destroy
end
