class TrainingPlatform::CommentsController < TrainingPlatform::ApplicationController
  def index
    #@commentable = Task.where(id: params[:commentable_id]).first
     @commentable = eval("#{params[:commentable_name]}.where(id: #{params[:commentable_id]}).first")
     respond_with @commentable
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
