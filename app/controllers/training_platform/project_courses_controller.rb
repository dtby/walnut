class TrainingPlatform::ProjectCoursesController < TrainingPlatform::ApplicationController
	before_action :set_project
  def index
  	@project_courses = @project.project_courses
  end

  def new
  	@project_course = @project.project_courses.new
    respond_to do |format|
      format.js
    end
  end

  def batch_create
  end

  private
  def set_project
  	@project = Project.find(params[:project_id])
  end
end
