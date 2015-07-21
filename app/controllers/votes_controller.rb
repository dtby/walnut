class VotesController < ApplicationController
  before_action :authenticate_user!
  respond_to :js, :json

  #收藏、点赞
  def create
    promise_class = ["Recruitment", "Comment", "Interview"]
    @voteable_class = params[:voteable_type]
    unless promise_class.include? @voteable_class
      @success = false
    else
      #获取要收藏的对象
      voteable = eval("#{@voteable_class}.where(id: #{params[:voteable_id]}).first")
      if voteable.present?
        @success = true
        @is_like = current_user.try(:voted_up_on?,voteable)
        @is_like ? (voteable.disliked_by current_user) : (voteable.liked_by current_user)
      else
        @success = false 
      end
    end
    respond_with @success, @is_like
  end
end
