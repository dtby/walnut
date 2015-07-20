module Admin
  class CoursesController < Admin::ApplicationController
    before_action :set_course, only: [:edit, :update, :destroy]
    before_action :association_variables, only: [:new, :edit]
    def index
      @courses = Course.page(params[:page]).per(10)
    end

    def new
      @course = Course.new
    end

    def create
      pp params
      @course = Course.new(course_params)

      #存入课程展示图
      @course.image = Image.new if @course.image.blank?
      @course.image.avatar = params[:course][:image]

      #存入课程附件
      @course.attachment = Attachment.new if @course.attachment.blank?
      @course.attachment.content = params[:course][:attachment]

      if @course.save && @course.attachment.save
        flash.now[:notice] = "创建成功"
        return redirect_to admin_courses_url
      else
        return render :new
      end
    end

    def edit
    end

    def update
      @course.image = Image.new if @course.image.blank? && params[:course][:image].present?
      @course.attachment = Attachment.new if @course.attachment.blank? && params[:course][:attachment].present?
      if @course.update(course_params)
        @course.image.update(avatar: params[:course][:image]) if params[:course][:image].present?
        @course.attachment.update(content: params[:course][:attachment]) if params[:course][:attachment].present?
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

    def association_variables
      @categories = Category.all
      @colleges = College.all
      @teachers = Teacher.all
    end

    def course_params
      params.require(:course).permit(:title, :description, :view_count, :category_id, :teacher_id, :college_id, :detail)
    end
    def set_course
      @course = Course.find(params[:id])
    end
  end
end