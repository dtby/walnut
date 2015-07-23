module TrainingPlatform
	class ProjectsController < ApplicationController
	  respond_to :json

	  def index
	    respond_with Project.all
	  end

	  def show
	    respond_with Project.find(params[:id])
	  end

	  def create
	    respond_with Project.create(project_params)
	  end

	  def update
	    respond_with Project.update(params[:id], project_params)
	  end

	  def destroy
	    respond_with Project.destroy(params[:id])
	  end

	  private
	  def project_params
	    params.require(:project).permit(:id, :name, :description)
	  end
	end
end