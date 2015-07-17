# == Schema Information
#
# Table name: sms
#
#  id         :integer          not null, primary key
#  mobile     :string(255)      not null
#  code       :string(255)      default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Sms, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
