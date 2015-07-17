class CoursesController < ApplicationController
  before_action :set_courses, only: [:show, :detail]

  def index
    @categories = Category.all
  	@courses = Course.all
  end

  def show
  	@course.update(view_count: @course.view_count + 1)
  end

  def detail
    render "show"
  end

  def list
    @colleges = College.all
    @courses = Course.all
  end

  private
  def set_courses
    @course = Course.find(params[:id])
    @sub_courses = @course.sub_courses
  end
end
