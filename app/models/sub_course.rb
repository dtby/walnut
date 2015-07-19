# == Schema Information
#
# Table name: sub_courses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :integer
#

class SubCourse < ActiveRecord::Base
	has_one :image, as: :imageable, dependent: :destroy
	has_one :attachment, as: :attachmentable, dependent: :destroy
	acts_as_commentable

	  #发布评论并返回新的评论一览
  #参数，user:登录的用户，params：提交的参数
  def self.save_comment_return_comments user, params
  	sub_course = SubCourse.find(params[:sub_course_id])
  	if sub_course.blank?
  		nil
  	else
       #新评论保存
       if user.present? && params[:user_comment].present?
       	comment = Comment.build_from( sub_course, user.id, params[:user_comment] )
       	comment.save
       end

      #返回所有评论
      sub_course.root_comments.order("created_at DESC").page(params[:page])
    end
  end

end
