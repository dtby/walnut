class TrainingPlatform::UserProjectsController < TrainingPlatform::ApplicationController
  before_action :set_project

  def new
    @user_project = UserProject.new
    respond_with @user_project
  end

  #邀请成员
  def invite_member

  end

end
