# == Schema Information
#
# Table name: interviews
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  content        :string(255)
#  iv_category_id :integer
#  browse_count   :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  public_time    :string(255)
#  image_url      :string(255)
#  view_count     :integer
#

class Interview < ActiveRecord::Base
  belongs_to :iv_category
  acts_as_votable
  acts_as_commentable

    #发布评论并返回新的评论一览
  #参数，user:登录的用户，params：提交的参数
  def self.save_comment_return_comments user, params
    interview = Interview.find(params[:interview_id])
    if interview.blank?
      nil
    else
       #新评论保存
       if user.present? && params[:user_comment].present?
        comment = Comment.build_from( interview, user.id, params[:user_comment] )
        comment.save
       end

      #返回所有评论
      interview.root_comments.order("created_at DESC").page(params[:page])
    end
  end
end
