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
    self.No = Task.where(project_id: self.project_id).count
  end

  #待办中、进行中、已完成、验收通过、验收失败
  enum state: { waiting: 1, doing: 2, completed: 3, acceptance: 4, failure: 5 }
  State = { waiting: "待办中", doing: "进行中", completed: "已完成", acceptance: "验收通过", failure: "验收失败"  }

  aasm :column => :state, :enum => true do
    state :waiting, :initial => true
    state :doing
    state :completed
    state :acceptance
    state :failure

    event :wait do
      transitions from: [:waiting, :doing, :completed, :acceptance, :failure] , to: :waiting
    end

    event :do do
      transitions from: [:waiting, :doing, :completed, :acceptance, :failure] , to: :waiting
    end

    event :complete do
      transitions from: [:waiting, :doing, :completed, :acceptance, :failure] , to: :completed
    end

    event :accept do
      transitions from: [:waiting, :doing, :completed, :acceptance, :failure] , to: :acceptance
    end

    event :fail do
      transitions from: [:waiting, :doing, :completed, :acceptance, :failure] , to: :failure
    end


  end
end