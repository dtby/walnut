class SubCoursesController < ApplicationController
  def show
  	@course = Course.find_by(id: params[:course_id])
  	@sub_courses = @course.sub_courses
  	@sub_course = SubCourse.find(params[:id])
  end

  def detail
  end
end
