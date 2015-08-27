class InterviewsController < ApplicationController
  def index
    # @interviews = Interview.all
    @interviews = Interview.order(created_at: DESC).page(params[:page])
  end

  def show
    @interview = Interview.find(params[:id])

    @comment = Comment.new

    @comments = @interview.root_comments
                .order(created_at: DESC)
                .page(params[:page])
    @interview.update(view_count: @interview.view_count.present? ? (@interview.view_count + 1) : 1) 

    respond_with @comments
  end

  def create
    user = current_user
    @comments = Interview.save_comment_return_comments(user, params)
    respond_with @comments
  end
end
