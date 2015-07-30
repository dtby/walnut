class TrainingPlatform::CommentsController < TrainingPlatform::ApplicationController
  def index
  end
  def create
    @commentable = Comment.add_comment params[:commentable_name], params[:commentable_id], params[:body]
    respond_with @commentable
  end
  def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      @commentable = @comment.commentable
       respond_with @commentable
  end
end
