# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  project_id :integer
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ActiveRecord::Base
  belongs_to :project
  has_many :user_notifications
  has_one :user_project, through: :project

  #创建用户通知
  def generate_user_notification(user)
  	user_notification = self.user_notifications.build(user_id: user.id, state: 1)
  	user_notification.save
  end
end
