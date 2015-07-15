# == Schema Information
#
# Table name: interviews
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  content        :string(255)
#  iv_category_id :integer
#  browse_count   :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Interview < ActiveRecord::Base
  belongs_to :iv_category
end
