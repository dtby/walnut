module Admin
	class ProfessionsController < Admin::ApplicationController
		before_action :set_profession, only: [:edit, :update, :destroy]
		def index
			@professions = Profession.page(params[:page]).per(10)
		end

		def new
			@profession = Profession.new
		end

		def create
			@profession = Profession.new(profession_params)
			@profession.image = Image.new if @profession.image.blank?
			@profession.image.avatar = params[:profession][:image]
			if @profession.save
				flash.now[:notice] = "创建成功"
				redirect_to admin_professions_path
			else
				render :new
			end
		end

		def edit
		end

		def update
			@profession.image = Image.new if @profession.image.blank? && params[:profession][:image].present?
			if @profession.update(profession_params)
				@profession.image.update(avatar: params[:profession][:image])
				flash.now[:notice] = "更新成功"
				redirect_to admin_professions_path
			else
				return :update
			end
		end

		def destroy
			@profession.destroy
			redirect_to admin_professions_path
		end

		private
			def profession_params
				params.require(:profession).permit(:name, :introduce)
			end

			def set_profession
				@profession = Profession.find(params[:id])
			end
	end
end