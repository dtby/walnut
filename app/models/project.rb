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
  has_many :announces, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :project_courses, dependent: :destroy


  enum is_public: { open: true, close: false }
  IsPublic = { open: '公开', close: '私密' }

  enum project_type: { default: 0, follow: 1, together: 2 }
  ProjectType = { default: '默认', follow: '跟我练', together: '一起来搞' }

  validates :name, presence: true


  #任务完成以及验收通过的百分比
  def task_percentage
    return 0 if self.tasks.count == 0
    (((self.tasks.completes.count + self.tasks.acceprances.count).to_f/self.tasks.count)*100).to_i
  end

  #检索用户项目状态(都要过滤掉当前用户)
  def on_invite_user_projects
    self.user_projects.where.not(user_id: current_user.id).where(invite: false)
  end

  def invited_user_projects
    self.user_projects.where.not(user_id: current_user.id).where(invite: true)
  end


  #根据当前登录用户以及列表需显示的数据显示相关项目
  #type: 需要显示项目的种类
  def self.list_projects type, query = nil
    if query.blank?
      case type
      when "self"
        includes(:user_projects).where(user_projects: {user_id: current_user.id})
      when "create"
        joins(:user_projects).where("user_projects.user_id = #{current_user.id} and user_projects.role = 1")
      when "join"
        joins(:user_projects).where("user_projects.user_id = #{current_user.id} and user_projects.role <> 1")
      when "collect"
        joins(:votes_for).where(votes: { vote_scope: "collect", vote_flag: true, voter_id: current_user.id, voter_type: current_user.class})
      when "pigeonhole"
        joins(:votes_for).where(votes: { vote_scope: "pigeonhole", vote_flag: true, voter_id: current_user.id, voter_type: current_user.class})
      else
        where(is_public: true)
      end
    else
      search(include: [:user_projects]) do 
        fulltext query # 模糊检索
        with :is_public, true
      end.results
    end
  end

  #取得当前项目的相对应成员
  def get_member
    User.includes(:user_projects).where(user_projects: { project_id: self.id, invite: true }).order("user_projects.role")
  end

  #solr搜索
  searchable do
    text :name, :description
    boolean :is_public
  end
end
