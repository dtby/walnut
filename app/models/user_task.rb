# == Schema Information
#
# Table name: user_tasks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  task_id    :integer
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  scope :principal, -> { where role: 1 }
  scope :helpers, -> { where role: 2 }

  after_save do
    Comment.add_comment_by_commentable self.try(:task),"assign" if self.user_id_changed? && self.role == "principal"
    Comment.add_comment_by_commentable self.try(:task),"add_helper",self.try(:user).try(:show_name) if self.user_id_changed? && self.role == "helper"
  end

  after_destroy do
    Comment.add_comment_by_commentable self.try(:task),"remove_helper",self.try(:user).try(:show_name) if self.role == "helper"
  end

  #负责人、协同者 
  enum role: { principal: 1, helper: 2 }
  Role = { principal: "负责人", helper: "协同者" }
end
