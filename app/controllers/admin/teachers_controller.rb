module Admin
  class TeachersController < Admin::ApplicationController
    before_action :set_teacher, only: [:edit, :update, :destroy]
    def index
      @teachers = Teacher.all.page(params[:page]).per(10)
    end

    def new
      @teacher = Teacher.new
    end

    def create
      @teacher = Teacher.new(teacher_params)
      #存入教师头像
      @teacher.image = Image.new if @teacher.image.blank?
      @teacher.image.avatar = params[:teacher][:image]
      if @teacher.save
        flash.now[:notice] = "创建成功"
        return redirect_to admin_teachers_url
      else
        return render :new
      end
    end

    def edit
    end

    def update
      @teacher.image = Image.new if @teacher.image.blank? && params[:teacher][:image].present?
      if @teacher.update(teacher_params)
        @teacher.image.update(avatar: params[:teacher][:image]) if params[:teacher][:image].present?
        flash.now[:notice] = "更新成功"
        return redirect_to admin_teachers_url
      else
        return :update
      end
    end

    def destroy
      @teacher.destroy
      return redirect_to admin_teachers_url
    end

    def show
    end

    private

    def teacher_params
      params.require(:teacher).permit(:name, :description, :deleted_at)
    end
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end
  end
end