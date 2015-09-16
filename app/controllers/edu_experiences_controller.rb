class EduExperiencesController < ApplicationController
	def index
		@edu_experiences = edu_experience.all.page(params[:page]).per(10)
	end

	def show
	end

	def new
		@edu_experience = EduExperience.new
	end

	def create
		@edu_experience = EduExperience.new(edu_experience_params)
		if @edu_experience.save
			flash[:notice] = "创建成功"
			return redirect_to my_resumes_user_index_path
		else
			flash[:notice] = "创建失败"
			return redirect_to my_resumes_user_index_path
		end
	end

	def edit
	end

	def destroy
		@edu_experience.destroy
		redirect_to my_resumes_user_index_path
	end

	def update
		if @edu_experience.update(edu_experience_params)
			flash[:notice] = "更新成功"
			return redirect_to my_resumes_user_index_path
		else
			flash[:notice] = "更新失败"
			return redirect_to my_resumes_user_index_path
		end
	end

	private
		def edu_experience_params
				params.require(:edu_experience).permit(:school, :time, :major, :education)
		end
end
