# == Schema Information
#
# Table name: user_recruitments
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  recruitment_id :integer
#  state          :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  deliver_time   :time
#

class UserRecruitment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recruitment
end
