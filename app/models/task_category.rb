# == Schema Information
#
# Table name: task_categories
#
#  id          :integer          not null, primary key
#  project_id  :integer
#  name        :string(255)
#  description :string(255)
#  unfinished  :integer          default(0)
#  total       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TaskCategory < ActiveRecord::Base

	#添加默认排序为id倒序
	default_scope {order('id DESC')}

  belongs_to :project
  has_many :tasks, dependent: :destroy
  acts_as_commentable

  #创建时记录操作记录
  after_create do
    Comment.add_comment_by_commentable self,"create" 
    Notification.add_notification_on_project self.project, :task_category_create, self
  end

  after_destroy do
    Notification.add_notification_on_project self.project, :task_category_delete, self
  end

  validates :name, presence: true
end
