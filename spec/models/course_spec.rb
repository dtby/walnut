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

require 'rails_helper'

RSpec.describe Course, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
