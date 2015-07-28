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
  has_many :user_tasks, dependent: :destroy 
  has_many :users, through: :user_tasks

  scope :waits, -> { where state: 1 }
  scope :dos, -> { where state: 2 }
  scope :completes, -> { where state: 3 }
  scope :acceprances, -> { where state: 4 }

  validates :name, presence: true

  #序号No状态、优先级的初始化赋值
  before_create do
    self.No = Task.where(project_id: self.project_id).count + 1
    self.state = 1
    self.level = 2
  end


  #待办中、进行中、已完成、验收通过、验收失败
  enum state: { waiting: 1, doing: 2, completed: 3, acceptance: 4 }
  State = { waiting: "待办中", doing: "进行中", completed: "已完成", acceptance: "验收通过", failure: "验收失败"  }

  #重要、普通、不重要 
  enum level: { high: 1, normal: 2, low: 3 }
  Level = { high: "重要", normal: "普通", low: "不重要" }

  aasm column: :state, enum: true do
    state :waiting, initial: true
    state :doing
    state :completed
    state :acceptance
    state :failure

    event :wait do
      transitions from: [:doing, :completed, :acceptance] , to: :waiting 
    end

    event :do do
      transitions from: [:waiting, :completed, :acceptance] , to: :doing
    end

    event :complete do
      transitions from: [:waiting, :doing, :acceptance] , to: :completed
    end

    event :accept do
      transitions from: [:waiting, :doing, :completed] , to: :acceptance
    end

    event :fail do
      transitions from: [:doing, :completed, :acceptance] , to: :waiting
    end
  end


  #获取当前任务的负责人
  def get_principal_user
    User.includes(:user_tasks).where(user_tasks: {task_id: self.id, role: 1}).first
  end

end
