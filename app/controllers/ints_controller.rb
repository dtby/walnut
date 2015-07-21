class  IntsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js, :json

  #收藏、点赞
  def create
    promise_class = ["Interview"]
    @intable_class = params[:intable_type]
    unless promise_class.include? @intable_class
      @success = false 
    else
      #获取要收藏的对象
      intable = eval("#{@intable_class}.where(id: #{params[:intable_id]}).first")
      if intable.present?
        @success = true
        @is_like = current_user.try(:inted_up_on?,intable)
        @is_like ? (intable.disliked_by current_user) : (intable.liked_by current_user)
      else
        @success = false 
      end
    end
    respond_with @success, @is_like
  end
end
