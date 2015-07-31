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
end
