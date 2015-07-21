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

  #创建者、负责人、协同者 
  enum role: { creator: 1, principal: 2, helper: 3 }
  Role = { creator: "创建者", principal: "负责人", helper: "协同者" }
end
