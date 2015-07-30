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

  #批量添加课程
  def batch_create
    @courses = Course.where(id: params[:course_ids])
    @courses.each do |course|
      @project_course = ProjectCourse.new
      @project_course.course_id = course.id
      @project_course.project_id = @project.id
      @project_course.save
    end
    return render js: "window.location(history.go(0));"
    respond_to do |format|
      format.js
    end
  end

  private
  def set_project
  	@project = Project.find(params[:project_id])
  end
end
