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
  include AASM

  belongs_to :user
  belongs_to :notification

  scope :unreads, -> { where state: 1 }

  enum state: { unread: 1, read: 2}

  aasm column: :state, enum: true do
    state :unread, initial: true
    state :read

    event :reading do
      transitions from: :unread , to: :read
    end
  end


  #当前用户、某项目的所有通知
  def self.read_all_by_current_user project = nil 
    user_notifications = project.present? ? self.joins(:notification).where(user_notifications: { user_id: current_user.id, state: 1 }, notifications: { project_id: project.id }) : current_user.user_notifications.unread
    user_notifications.each do |user_notification|
      user_notification.reading! if user_notification.may_reading?
    end
  end
end
