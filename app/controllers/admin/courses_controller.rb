module Admin
  class CoursesController < ApplicationController
    before_action :set_course, only: [:edit, :update, :destroy]
    def index
      @courses = Course.page(params[:page]).per(10)
    end

    def new
      @categories = Category.all
      @colleges = College.all
      @course = Course.new
    end

    def create
      @course = Course.new(course_params)
      if @course.save
        flash.now[:notice] = "创建成功"
        return redirect_to admin_courses_url
      else
        return render :new
      end
    end

    def edit
    end

    def update
      if @course.update(course_params)
        flash.now[:notice] = "更新成功"
        return redirect_to admin_courses_url
      else
        return :update
      end
    end

    def destroy
      @course.destroy
      return redirect_to admin_courses_url
    end

    def show
    end

    private

    def course_params
      params.require(:course).permit(:title, :description, :view_count)
    end
    def set_course
      @course = Course.find(params[:id])
    end
  end
end