# == Schema Information
#
# Table name: iv_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  sort_no    :integer          default(1000)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe IvCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
