class TrainingPlatform::ProjectsController < TrainingPlatform::ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]

  def index
    @search = Project.list_projects(params[:type], params[:q])
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
      flash[:notice] = "项目创建成功"
      UserProject.create(user_id: current_user.id, project_id: @project.id, role: 1, invite: true)
    end
    respond_with @project
  end

  def edit
    respond_with @project
  end

  def update
    if @project.update project_params
      flash[:notice] = "项目更新成功"
    end
    respond_with @project
  end

  def destroy
    respond_with @project.destroy
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
          respond_to do |format|
            format.js {render js: "location.href='#{training_platform_root_path}'"}
          end
        else
          return redirect_to training_platform_root_path
        end
      end
    end
end
