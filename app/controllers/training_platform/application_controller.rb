class TrainingPlatform::ApplicationController < ApplicationController
  before_action :authenticate_user!
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
end
