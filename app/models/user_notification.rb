# == Schema Information
#
# Table name: user_notifications
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  notification_id :integer
#  state           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UserNotification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification
end
