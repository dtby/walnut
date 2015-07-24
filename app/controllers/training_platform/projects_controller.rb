class TrainingPlatform::ProjectsController < TrainingPlatform::ApplicationController

  def index
    respond_with Project.all
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
    @project.save
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
