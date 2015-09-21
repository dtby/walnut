class Admin::ProfessionStagesController < Admin::ApplicationController
	before_action :set_profession, only: [:index, :new, :create, :edit]
	before_action :set_profession_stage, only: [:edit, :update, :destroy, :courses, :new_course]
	def index
		@profession_stages = @profession.profession_stages.page(params[:page]).per(10)
	end

	def new
		@profession_stage = @profession.profession_stages.build
	end

	def create
		@profession_stage = @profession.profession_stages.build(profession_stage_params)
		if @profession_stage.save
			flash.now[:notice] = "创建成功"
			redirect_to admin_profession_profession_stages_path
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @profession_stage.update(profession_stage_params)
			flash.now[:notice] = "编辑成功"
			redirect_to admin_profession_profession_stages_path
		else
			render :edit
		end
	end

	def destroy
		@profession_stage.destroy
		flash.now[:notice] = "删除成功"
		redirect_to admin_profession_profession_stages_path		
	end

	#显示技术体系各阶段的全部课程
	def courses
		@profession_stage_courses = @profession_stage.courses.page(params[:page]).per(10)
	end

	#为技术体系的阶段添加课程
	def new_course
		@courses = Course.all.pluck(:id, :title)
	end

	#创建阶段课程
	def create_course
		params[:course_id].each do |course_id|
			StageCourse.find_or_create_by!(stage_courseable_id: params[:stage_courseable_id], 
				stage_courseable_type: params[:stage_courseable_type], 
				course_id: course_id)
		end
		redirect_to courses_admin_profession_profession_stage_path
	end	

	private
	def profession_stage_params
		params.require(:profession_stage).permit(:name, :discribe)
	end

	def set_profession
		@profession = Profession.find(params[:profession_id])
	end

	def set_profession_stage
		@profession_stage = ProfessionStage.find(params[:id])		
	end
end