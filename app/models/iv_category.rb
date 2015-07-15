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

class IvCategory < ActiveRecord::Base
end
