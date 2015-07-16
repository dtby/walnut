class VotesController < ApplicationController
  before_action :authenticate_user!
  respond_to :js, :json

  #收藏、点赞
  def create
    promise_class = ["Recruitment"]
    @voteable_class = params[:voteable_type]
    @is_like = params[:is_like]
    unless promise_class.include? @voteable_class
      @success = false 
    else
      #获取要收藏的对象
      voteable = eval("#{@voteable_class}.where(id: #{params[:voteable_id]}).first")
      if voteable.present?
        @success = true
        @is_like == "false" ? (voteable.liked_by current_user) : (voteable.disliked_by current_user)
      else
        @success = false 
      end
    end
    respond_with @success, @is_like, @voteable_class
  end
end
