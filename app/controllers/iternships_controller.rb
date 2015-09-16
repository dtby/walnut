class IternshipsController < ApplicationController
	def index
		@iternships = Iternship.all.page(params[:page]).per(10)
	end

	def show
	end

	def new
		@iternship = Iternship.new
	end

	def create
		@iternship = Iternship.new(iternship_params)
		if @iternship.save
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
		@iternship.destroy
		redirect_to my_resumes_user_index_path
	end

	def update
		if @iternship.update(iternship_params)
			flash[:notice] = "更新成功"
			return redirect_to my_resumes_user_index_path
		else
			flash[:notice] = "更新失败"
			return redirect_to my_resumes_user_index_path
		end
	end

	private
		def iternship_params
				params.require(:iternship).permit(:company, :time, :address, :job)
		end

end
