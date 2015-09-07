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
			#头像赋值
		    if params[:train][:image]
		      #头像处理,未上传头像显示默认图片
		      @train.image = Image.new if @train.image.blank?
		      @train.image.avatar = params[:train][:image]
		    end
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
			@train.image = Image.new if @train.image.blank? && params[:train][:image].present?
			if @train.update(train_params)
				 @train.image.update(avatar: params[:train][:image]) if params[:train][:image].present?
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
			params.require(:train).permit(:title, :introduce, :syllabus, :prospect, :characteristic)
		end
		def set_train
			@train = Train.find(params[:id])
		end
	end
end