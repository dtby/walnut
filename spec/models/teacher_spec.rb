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

require 'rails_helper'

RSpec.describe Teacher, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
