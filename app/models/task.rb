# == Schema Information
#
# Table name: tasks
#
#  id               :integer          not null, primary key
#  project_id       :integer
#  task_category_id :integer
#  No               :integer
#  name             :string(255)
#  description      :string(255)
#  end_time         :date
#  level            :integer
#  state            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Task < ActiveRecord::Base
  include AASM

  belongs_to :project
  belongs_to :task_category

  #序号No赋值
  before_create do
    self.No = Task.where(project_id: self.project_id).count + 1
  end

  #待办中、进行中、已完成、验收通过、验收失败
  enum state: { waiting: 1, doing: 2, completed: 3, acceptance: 4 }
  State = { waiting: "待办中", doing: "进行中", completed: "已完成", acceptance: "验收通过", failure: "验收失败"  }

  #重要、普通、不重要 
  enum level: { important: 1, general: 2, unimportant: 3 }
  Level = { important: "重要", general: "普通", unimportant: "不重要" }

  aasm column: :state, enum: true do
    state :waiting, initial: true, after_commit: :update_task_category_total_and_unfinished
    state :doing
    state :completed
    state :acceptance
    state :failure

    event :wait, after_commit: Proc.new { set_process(old_state, :waiting) } do
      transitions from: [:doing, :completed, :acceptance] , to: :waiting 
    end

    event :do, after_commit: Proc.new { set_process(old_state, :doing) } do
      transitions from: [:waiting, :completed, :acceptance] , to: :doing
    end

    event :complete, after_commit: Proc.new { set_process(old_state, :completed) } do
      transitions from: [:waiting, :doing, :acceptance] , to: :completed
    end

    event :accept, after_commit: Proc.new { set_process(old_state, :acceptance) } do
      transitions from: [:waiting, :doing, :completed] , to: :acceptance
    end

    event :fail, after_commit: Proc.new { set_process(old_state, :waiting) } do
      transitions from: [:doing, :completed, :acceptance] , to: :waiting
    end
  end

  #更新task对应task_category的总任务数以及未完成任务数
  def update_task_category_total_and_unfinished old_state, new_state
    case new_state.to_sym
    when :waiting
      self.task_category.update_attributes({unfinished: self.unfinished + 1}) unless old_state == :doing
    when :doing
      self.task_category.update_attributes({unfinished: self.unfinished + 1}) unless old_state == :waiting
    when :completed
      self.task_category.update_attributes({unfinished: self.unfinished - 1}) unless old_state == :acceptance
    when :acceptance
      self.task_category.update_attributes({unfinished: self.unfinished - 1}) unless old_state == :completed
    else
      self.task_category.update_attributes({unfinished: (self.unfinished + 1), total: (self.total + 1)})
    end
  end

end
