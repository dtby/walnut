class ProjectsExpsController < ApplicationController
	def index
	end

	def show
	end

	def new
		@projects_exp = ProjectsExp.new
	end

	def create
		@user = current_user
		@projects_exps = ProjectsExp.all
		@projects_exp = ProjectsExp.new(projects_exp_params)
		if @projects_exp.save
			flash[:notice] = "创建成功"
			respond_with(@projects_exps)
		else
			flash[:notice] = "创建失败"
			respond_with(@projects_exps)
		end
	end

	def edit
	end

	def destroy
		@projects_exp.destroy
		redirect_to my_resumes_user_index_path
	end

	def update
		if @projects_exp.update(projects_exp_params)
			flash[:notice] = "更新成功"
			respond_with(@projects_exp)
		else
			flash[:notice] = "更新失败"
			respond_with(@projects_exp)
		end
	end

	private
		def projects_exp_params
				params.require(:projects_exp).permit(:title, :time, :role, :certificate, :custom)
		end

end
