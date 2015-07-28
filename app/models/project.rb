# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  is_public   :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Project < ActiveRecord::Base

  acts_as_votable
  has_many :task_categories, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :announces
  has_many :notifications


  enum is_public: { open: true, close: false }
  IsPublic = { open: '公开', close: '私密' }

  validates :name, presence: true


  #任务完成以及验收通过的百分比
  def task_percentage
    return 0 if self.tasks.count == 0
    (self.tasks.completes.count + self.tasks.acceprances.count)/self.tasks.count
  end

  #检索用户项目状态
  def on_invite_user_projects
    self.user_projects.where(invite: false)
  end

  def invited_user_projects
    self.user_projects.where(invite: true)
  end


  #根据当前登录用户以及列表需显示的数据显示相关项目
  #type: 需要显示项目的种类
  def self.list_projects type
    case type
    when "self"
      Project.includes(:user_projects).where(user_projects: {user_id: current_user.id, role: 1})
    when "join"
      Project.joins(:user_projects).where("user_projects.user_id = #{current_user.id} and user_projects.role <> 1")
    when "collect"
      current_user.votes.up.for_type(Project).where(vote_scope: "collect").votables
    when "pigeonhole"
      current_user.votes.up.for_type(Project).where(vote_scope: "pigeonhole").votables
    else
      Project.includes(:user_projects).where(user_projects: {user_id: current_user.id})
    end
  end

  #取得当前项目的所有成员
  def get_member
    User.includes(:user_projects).where(user_projects: { project_id: self.id, invite: true }).order("user_projects.role")
  end
end
