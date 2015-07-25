class TrainingPlatform::ProjectsController < TrainingPlatform::ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]

  def index
    @projects = Project.includes(:user_projects).where(user_projects: {user_id: 1})
    respond_with @projects
  end

  def show
    respond_with Project.find(params[:id])
  end

  def new
  	@project = Project.new
  	respond_with @project
  end

  def create
    @project = Project.new project_params
    if @project.save
      UserProject.create(user_id: current_user.id, project_id: @project.id, role: 1)
    end
    respond_with @project
  end

  def edit
    respond_with @project
  end

  def update
    @project.update project_params
    respond_with @project
  end

  def destroy
    respond_with Project.destroy(params[:id])
  end

  private
    def project_params
      params.require(:project).permit(:name, :description, :is_public)
    end

    def set_project
      @project = Project.where(id: params[:id]).first
      if @project.blank? 
        flash[:notice] = "当前数据不存在"
        if request.xhr?
          return redirect_to training_platform_root_path
        else
          respond_to do |format|
            format.js {render js: "location.href='#{training_platform_root_path}'"}
          end
        end
      end
    end
end
