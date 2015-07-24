class TrainingPlatform::ProjectsController < TrainingPlatform::ApplicationController

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

  def update
    respond_with Project.update(params[:id], project_params)
  end

  def destroy
    respond_with Project.destroy(params[:id])
  end

  private
  def project_params
    params.require(:project).permit(:name, :description, :is_public)
  end
end
