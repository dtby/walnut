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
#

class UserProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  #创建者、管理者、成员、访客
  enum role: { creator: 1, admin: 2, member: 3 }
  Role = { creator: "创建者", admin: "管理者", member: "成员" }
end
