module Admin
	class CategoriesController < ApplicationController
		before_action :set_category, only: [:edit, :update, :destroy]
		def index
			@categories = Category.page(params[:page]).per(10)
		end

		def new
			@category = Category.new
		end

		def create
			@category = Category.new(category_params)
			if @category.save
				flash.now[:notice] = "创建成功"
				redirect_to admin_categories_path
			else
				render :new
			end
		end

		def edit
		end

		def update
			if @category.update(category_params)
				flash.now[:notice] = "更新成功"
				redirect_to admin_categories_path
			else
				render :update
			end
		end

		def destroy
			@category.destroy
			redirect_to admin_categories_path
		end

		def show
		end

		private

		def category_params
			params.require(:category).permit(:name, :deleted_at)
		end
		def set_category
			@category = Category.find(params[:id])
		end
	end
end