class TrainingPlatform::CommentsController < TrainingPlatform::ApplicationController
  def create
    @commentable = Comment.add_comment params[:commentable_name], params[:commentable_id], params[:body]
    respond_with @commentable
  end
end
