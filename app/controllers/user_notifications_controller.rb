class UserNotificationsController < ApplicationController
  before_action :authenticate_user!

  def read
    user_notification = UserNotification.where(id: params[:id], user_id: current_user.id).first
    user_notification.reading! if user_notification.present? && user_notification.may_reading?
    redirect_to my_messages_user_index_path
  end
end
