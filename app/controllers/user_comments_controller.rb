class CommentsController < ApplicationController
	def create
		user = current_user
	    @comments = User.save_comment_return_comments(user, params)
	    respond_with @comments
	end
	def index
	
   		@comment = Comment.new

		@comments = @comment.root_comments.order("created_at DESC").page(params[:page])
		respond_with @comments
  	end

end
