# == Schema Information
#
# Table name: sub_courses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :integer
#

require 'rails_helper'

RSpec.describe SubCourse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
