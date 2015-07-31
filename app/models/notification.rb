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



  #创建、更新任务时创建通知，并指定给相关用户
  def self.add_notification_on_project project, type, notificationable
    content = ""
    case type.try(:to_sym)
    when :announce_create
      content = "#{current_user.try(:name)} 创建了公告“#{ notificationable.title }”"
    when :announce_delete
      content = "#{current_user.try(:name)} 删除了公告“#{ notificationable.title }“"
    when :task_category_create
      content = "#{current_user.try(:name)} 创建了任务列表“#{ notificationable.name }“"
    when :task_category_delete
      content = "#{current_user.try(:name)} 删除了任务列表“#{ notificationable.name }“"
    when :task_create
      content = "#{current_user.try(:name)} 创建了任务“#{ notificationable.name }“"
    when :task_delete
      content = "#{current_user.try(:name)} 删除了任务“#{ notificationable.name }“"
    end
    notification = self.create(project_id: project.id, content: content)

    project.get_member.each do |user|
      notification.user_notifications.build(user_id: user.id, state: 1).save
    end
  end
end
