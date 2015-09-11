module Admin
	class TechnologiesController < Admin::ApplicationController
		before_action :set_technology, only: [:edit, :update, :destroy]
		def index
			@technologies = Technology.page(params[:page]).per(10)
		end

		def new
			@technology = Technology.new
		end

		def create
			@technology = Technology.new(technology_params)
			@technology.image = Image.new if @technology.image.blank?
		      @technology.image.avatar = params[:technology][:image]
			if @technology.save
				flash.now[:notice] = "创建成功"
				redirect_to admin_technologies_path
			else
				render :new
			end
		end

		def edit
		end

		def update
			@technology.image = Image.new if @technology.image.blank? && params[:technology][:image].present?
			if @technology.update(technology_params)
				@technology.image.update(avatar: params[:technology][:image])
				flash.now[:notice] = "更新成功"
				redirect_to admin_technologies_path
			else
				return :update
			end
		end

		def destroy
			@technology.destroy
			redirect_to admin_technologies_path
		end

		private
			def technology_params
				params.require(:technology).permit(:name)
			end

			def set_technology
				@technology = Technology.find(params[:id])
			end
	end
end
