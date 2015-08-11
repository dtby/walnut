class TrainingPlatform::UserProjectsController < TrainingPlatform::ApplicationController
  before_action :set_project

  def new
    @user_project = UserProject.new
    @task_categories = @project.task_categories
  end

  def create
    @user_project = UserProject.new user_project_params
    @user_project.user_id = User.where(["email = :value OR mobile = :value", { :value => params[:user_project][:user_id] }]).first.try(:id)
    if @user_project.save
      #邮件发送
      UserMailer.invite_member(@user_project).deliver_later
    end
    respond_with @user_project
  end

  #邀请成员
  def invite_member
    ps = (Des.decode params[:r]).split(",")
    @success = false

    #解密失败
    if ps.blank?
      flash[:notice] = "无效链接"
    else
      @user_project = UserProject.where(id: ps[0], updated_at: ps[1]).first

      if @user_project.blank?
        flash[:notice] = "链接失效"
      else
        @user_project.update_attributes({invite: true})
        @success = true
      end
    end

    respond_with @success, @info, @user_project
  end


  private
    def user_project_params
      params.require(:user_project).permit(:role, :project_id, :user_id)
  end
end
