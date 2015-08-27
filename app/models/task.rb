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
  acts_as_commentable
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :skills, :interests

  belongs_to :project
  belongs_to :task_category
  has_many :user_tasks, dependent: :destroy 
  has_many :users, through: :user_tasks
  has_many :attachments, as: :attachmentable, dependent: :destroy

  scope :waits, -> { where state: 1 }
  scope :dos, -> { where state: 2 }
  scope :completes, -> { where state: 3 }
  scope :acceprances, -> { where state: 4 }
  
  validates :name, presence: true

  # 序号No状态、优先级的初始化赋值
  before_create do
    self.No = Task.where(project_id: self.project_id).count + 1
    self.state = 1 # 状态默认为待办中
    self.level = 2 # 优先级默认是普通
  end
  # 创建时记录操作记录
  after_create do
    Comment.add_comment_by_commentable self,"create" 
    Notification.add_notification_on_project self.project, :task_create, self
  end
  # task更新后保存一些操作记录
  after_update :add_comment

  after_destroy do
    Notification.add_notification_on_project self.project, :task_delete, self
  end


  # 待办中、进行中、已完成、验收通过、验收失败
  enum state: { waiting: 1, doing: 2, completed: 3, acceptance: 4 }
  State = { waiting: '待办中', doing: '进行中', completed: '已完成', acceptance: '验收通过' }

  # 重要、普通、不重要 
  enum level: { high: 1, normal: 2, low: 3 }
  Level = { high: '重要', normal: '普通', low: '不重要' }

  aasm column: :state, enum: true do
    state :waiting, initial: true
    state :doing
    state :completed
    state :acceptance

    event :wait do
      transitions from: [:doing, :completed, :acceptance], to: :waiting 
    end

    event :do do
      transitions from: [:waiting, :completed, :acceptance], to: :doing
    end

    event :complete do
      transitions from: [:waiting, :doing, :acceptance], to: :completed
    end

    event :accept do
      transitions from: [:waiting, :doing, :completed], to: :acceptance
    end

    event :fail do
      transitions from: [:doing, :completed, :acceptance], to: :waiting
    end
  end


  # 获取当前任务的负责人
  def get_principal_user
    User.includes(:user_tasks).where(user_tasks: {task_id: self.id, role: 1}).first
  end

  # 获取协同者
  def get_helpers
    User.includes(:user_tasks).where(user_tasks: {task_id: self.id, role: 2})
  end


  # task更新后添加对应评论
  private 

  def add_comment
    
    # 分类变更
    Comment.add_comment_by_commentable(self, 'move') if task_category_id_changed?

    # 截止日期设定
    Comment.add_comment_by_commentable(self, 'settime') if end_time_changed?

    # 状态改变
    Comment.add_comment_by_commentable(self, state) if state_changed?

    # 优先级改变
    Comment.add_comment_by_commentable(self, 'level') if level_changed?
  end

end
