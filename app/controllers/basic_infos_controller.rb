class BasicInfosController < ApplicationController
	def index
		@basic_infos = basic_info.all.page(params[:page]).per(10)
	end

	def show
	end

	def new
		@basic_info = BasicInfo.new
	end

	def create
		@basic_info = BasicInfo.new(basic_info_params)
		if @basic_info.save
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
		@basic_info.destroy
		redirect_to my_resumes_user_index_path
	end

	def update
		if @basic_info.update(basic_info_params)
			flash[:notice] = "更新成功"
			return redirect_to my_resumes_user_index_path
		else
			flash[:notice] = "更新失败"
			return redirect_to my_resumes_user_index_path
		end
	end

	private
		def basic_info_params
				params.require(:basic_info).permit(:title, :classify, :content, :picture_url)
		end

	end


end
