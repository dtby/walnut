class Admin::TechnologyStagesController < Admin::ApplicationController
	before_action :set_technology, only: [:index, :new, :create, :edit]
	before_action :set_technology_stage, only: [:edit, :update, :destroy, :courses, :new_course]
	def index
		@technology_stages = @technology.technology_stages.page(params[:page]).per(10)
	end

	def new
		@technology_stage = @technology.technology_stages.build
	end

	def create
		@technology_stage = @technology.technology_stages.build(technology_stage_params)
		if @technology_stage.save
			flash.now[:notice] = "创建成功"
			redirect_to admin_technology_technology_stages_path
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @technology_stage.update(technology_stage_params)
			flash.now[:notice] = "编辑成功"
			redirect_to admin_technology_technology_stages_path
		else
			render :edit
		end
	end

	def destroy
		@technology_stage.destroy
		flash.now[:notice] = "删除成功"
		redirect_to admin_technology_technology_stages_path
	end

	#显示技术体系各阶段的全部课程
	def courses
		@technology_stage_courses = @technology_stage.courses.page(params[:page]).per(10)
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
		redirect_to courses_admin_technology_technology_stage_path
	end	

	private
	def technology_stage_params
		params.require(:technology_stage).permit(:name, :description)
	end
	def set_technology
		@technology = Technology.find(params[:technology_id])
	end
	def set_technology_stage
		@technology_stage = TechnologyStage.find(params[:id])
	end
end