class UserNotificationsController < ApplicationController
  before_action :authenticate_user!


  def index
    @user_notifications = current_user.user_notifications.includes(:notification)
    .order("user_notifications.created_at DESC").page(params[:page])
    respond_with @user_notifications
  end

  def read
    user_notification = UserNotification.where(id: params[:id], user_id: current_user.id).first
    user_notification.reading! if user_notification.present? && user_notification.may_reading?
    respond_with @user_notifications
  end

  def read_all
    UserNotification.read_all_by_current_user
    respond_with @project
  end
end
