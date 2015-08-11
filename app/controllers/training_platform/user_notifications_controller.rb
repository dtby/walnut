class TrainingPlatform::UserNotificationsController < TrainingPlatform::ApplicationController
  before_action :set_project

  def index
    @user_notifications = current_user.user_notifications.includes(:notification)
    .where(notifications: {project_id: params[:project_id]})
    .order("user_notifications.created_at DESC").page(params[:page])
    respond_with @user_notifications
  end

end
