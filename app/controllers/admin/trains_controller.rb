module Admin
	class TrainsController < Admin::ApplicationController
		before_action :set_train, only: [:edit, :update, :destroy]
		def index
			@trains = Train.all.page(params[:page]).per(10)
		end

		def new
			@train = Train.new
		end

		def create
			@train = Train.new(train_params)
			if @train.save
				flash.now[:notice] = "创建成功"
				return redirect_to admin_trains_path
			else
				return render :new
			end
		end

		def edit
		end

		def update
			if @train.update(train_params)
				flash.now[:notice] = "更新成功"
				return redirect_to admin_trains_path
			else
				return render :update
			end
		end

		def destroy
			@train.destroy
			return redirect_to admin_trains_path
		end

		def show
		end

		private

		def train_params
			params.require(:train).permit(:title, :picture_url, :introduce, :pv, :syllabus, :prospect, :characteristic)
		end
		def set_train
			@train = Train.find(params[:id])
		end
	end
end