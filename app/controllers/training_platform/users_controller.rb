class TrainingPlatform::UsersController < TrainingPlatform::ApplicationController
  before_action :set_project

  def index
  	@users = User.all
  end

  def show
    @user = User.where(id: params[:id]).first
  end
end
