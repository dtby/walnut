# == Schema Information
#
# Table name: announces
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Announce < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  acts_as_commentable

  #创建时记录操作记录
  after_create do
    Comment.add_comment_by_commentable self,"create" 
  end

  validates :title, :description, :user_id, :project_id, presence: true
end
