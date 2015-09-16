class IternshipsController < ApplicationController
	def index
	end

	def show
	end

	def new
		@iternship = Iternship.new
	end

	def create
		@user = current_user
		@iternships = Iternship.all
		@iternship = Iternship.new(iternship_params)
		if @iternship.save
			flash[:notice] = "创建成功"
			respond_with(@iternships)
		else
			flash[:notice] = "创建失败"
			respond_with(@iternships)
		end
	end

	def edit
	end

	def destroy
		@user = current_user
		@iternships = Iternship.all
		@iternship.destroy
		respond_with(@iternships)
	end

	def update
		if @iternship.update(iternship_params)
			flash[:notice] = "更新成功"
			respond_with(@iternships)
		else
			flash[:notice] = "更新失败"
			respond_with(@iternships)
		end
	end

	private
		def iternship_params
				params.require(:iternship).permit(:company, :time, :address, :job)
		end

end
