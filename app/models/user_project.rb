# == Schema Information
#
# Table name: user_projects
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  project_id :integer
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  invite     :boolean
#

class UserProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  #创建者、管理者、成员、访客
  enum role: { creator: 1, admin: 2, member: 3 }
  Role = { creator: "创建者", admin: "管理者", member: "成员" }


  validates :user_id, presence: {message: "不存在该用户"}
  validates_uniqueness_of :user_id, scope: :project_id, message: "该成员已经存在"


  #通过用户，项目读取user_project对象
  def self.get_user_project(user, project)
    UserProject.find_by(user_id: user.id, project_id: project.id)
  end
end
