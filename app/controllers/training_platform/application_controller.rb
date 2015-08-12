class TrainingPlatform::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user_in_project?
  layout 'training_platform'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def set_project
    @project = Project.where(id: params[:project_id]).first
    if @project.blank? 
      flash[:notice] = "当前数据不存在"
      if request.xhr?
        respond_to do |format|
          format.js {render js: "location.href='#{training_platform_root_path}'"}
        end
      else
        return redirect_to training_platform_root_path
      end
    end
  end

  private
    def current_user_in_project?
      unless params[:controller] == "training_platform/projects"
        if UserProject.where(user_id: current_user.id, project_id: params[:project_id], invite: true).blank?
          flash[:notice] = "没有权限访问该项目"
          redirect_to training_platform_root_path 
        end
      end
    end
end
