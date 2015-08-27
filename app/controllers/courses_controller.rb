class CoursesController < ApplicationController
  before_action :set_courses, only: [:show, :detail]

  def index
    @categories = Category.all
    category = Category.find_by(id: params[:category_id])
    if params[:category_id]
      @courses = category.courses
    else
      @courses = Course.all
    end
  end

  def show
    @course.update(view_count: @course.view_count + 1)
  end

  def detail
  end

  def list
    @colleges = College.all
    college = College.find_by(id: params[:college_id])
    if params[:college_id]
      @courses = college.courses
    else
      @courses = Course.all
    end
  end

  private
  
  def set_courses
    @course = Course.find(params[:id])
    @sub_courses = @course.sub_courses
  end
end
