module Admin
	class CollegesController < Admin::ApplicationController
		before_action :set_college, only: [:edit, :update, :destroy, :courses, :new_courses]
		def index
			@colleges = College.page(params[:page]).per(10)
		end

		def new
			@college = College.new
		end

		def create
			@college = College.new(college_params)
			#存入学院logo
		      @college.image = Image.new if @college.image.blank?
		      @college.image.avatar = params[:college][:image]

			if @college.save
				flash.now[:notice] = "创建成功"
				return redirect_to admin_colleges_url
			else
				return render :new
			end
		end

		def edit
		end

		def update
			@college.image = Image.new if @college.image.blank? && params[:college][:image].present?
			if @college.update(college_params)
				@college.image.update(avatar: params[:college][:image]) if params[:college][:image].present?
				flash.now[:notice] = "更新成功"
				return redirect_to admin_colleges_url
			else
				return :update
			end
		end

		def destroy
			@college.destroy
			return redirect_to admin_colleges_url
		end

		def show
		end

		#显示具体学校的全部课程
		def courses
			@college_courses = @college.courses.page(params[:page]).per(10)
		end

		#为学校添加课程页面
		def new_courses
			@courses = Course.all.pluck(:id, :title)
		end

		#创建学校课程
		def create_courses
			params[:course_id].each do |course_id|
				StageCourse.find_or_create_by!(stage_courseable_id: params[:stage_courseable_id], 
					stage_courseable_type: params[:stage_courseable_type], 
					course_id: course_id)
			end
			redirect_to courses_admin_college_path
		end

		private
			def college_params
				params.require(:college).permit(:name, :deleted_at)
			end
			def set_college
				@college = College.find(params[:id])
			end
	end
end