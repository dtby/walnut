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
  belongs_to :self_task, class_name: "Task", foreign_key: :task_id

  #负责人、协同者 
  enum role: { principal: 1, helper: 2 }
  Role = { principal: "负责人", helper: "协同者" }
end
