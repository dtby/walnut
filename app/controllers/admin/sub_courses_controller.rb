module Admin
	class SubCoursesController < Admin::ApplicationController
    before_action :set_course
		before_action :set_sub_course, only: [:edit, :update, :destroy]
		def index
			@sub_courses = @course.sub_courses.page(params[:page]).per(10)
		end

		def new
			@sub_course = @course.sub_courses.new
		end

		def create
			@sub_course = @course.sub_courses.new(sub_course_params)
			#子课程展示图
			@sub_course.image = Image.new if @sub_course.image.blank?
      @sub_course.image.avatar = params[:sub_course][:image]

			@sub_course.attachment = Attachment.new if @sub_course.attachment.blank?
			@sub_course.attachment.content = params[:sub_course][:attachment] if params[:sub_course][:attachment].present?
			@sub_course.attachment.file_url = params[:attachment_file_url] if params[:attachment_file_url].present?
			if @sub_course.save && @sub_course.attachment.save
				flash.now[:notice] = "课程创建成功"
				return redirect_to admin_course_sub_courses_path(@course)
			else
				flash.now[:notice] = "课程创建失败"
				return redirect_to admin_course_sub_courses_path(@course)
			end
		end

		def edit
		end

		def update
			@sub_course.attachment = Attachment.new if @sub_course.attachment.blank?

			#子课程展示图
			@sub_course.image = Image.new if @sub_course.image.blank? && params[:sub_course][:image].present?
			if @sub_course.update(sub_course_params) && @sub_course.attachment.update(content: params[:sub_course][:attachment])
				#子课程展示图
				@sub_course.image.update(avatar: params[:sub_course][:image]) if params[:sub_course][:image].present?
				if @sub_course.attachment.present?
				  @sub_course.attachment.update(file_url: params[:attachment_file_url]) if params[:attachment_file_url].present?
				else
					@sub_course.attachment = Attachment.new
					@sub_course.attachment.create(file_url: params[:attachment_file_url]) if params[:attachment_file_url].present?
				end
				flash.now[:notice] = "课程更新成功"
				redirect_to admin_course_sub_courses_path(@course)
			else
				flash.now[:notice] = "课程更新失败"
				redirect_to admin_course_sub_courses_path(@course)
			end
		end

		def destroy
      @sub_course.destroy
      return redirect_to admin_course_sub_courses_path(@course)
    end

		private

		def set_course
			@course = Course.find(params[:course_id])
		end

		def sub_course_params
			params.require(:sub_course).permit(:title, :description)
		end

		def set_sub_course
			@sub_course = @course.sub_courses.find(params[:id])
		end
	end
end