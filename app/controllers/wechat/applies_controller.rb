class Wechat::AppliesController < Wechat::ApplicationController
	before_action :set_applies, only: [:index, :destroy]
	before_action :set_apply, only: [:show, :edit, :update, :destroy]
	def home
	end

	def new
		@apply = Apply.new
	end

	def create
		@apply = Apply.new(apply_params)
		if @apply.save
			respond_to do |format|
				format.js {render js: "location.href='#{ wechat_apply_path(@apply)}'"}
			end
			flash[:notice] = "您好，#{@apply.name} <br>你已经提交成功，请耐心等待<br>我们将尽快和您联系"
		else
			respond_with @apply
		end
	end

	def edit
	end

	def update
		if @apply.update(apply_params)
			respond_to do |format|
				format.js {render js: "location.href='#{ wechat_apply_path(@apply)}'"}
			end
			flash[:notice] = "您好，#{@apply.name} <br>你已经修改成功，请耐心等待<br>我们将尽快和您联系"
		else
			render edit_wechat_apply_path
		end
	end

	def show
		flash[:notice] = "您好，#{@apply.name} <br>以下是你的报名详细信息<br>如有错误，请修改"
	end

	def index
	end

	def destroy
		if @apply.present?
			@apply.destroy
			respond_with @apply
		end
	end

	def error
	end

	private
		def apply_params
			params.require(:apply).permit(:openid, :name,  :sex, :phone, :email, :qq, :address, :situation, :degree, :way, :train_name, :school_name)
		end

		def set_applies
			@applies = Apply.where(openid: session[:openid]).order(created_at: :desc)
		end

		def set_apply
			@apply = Apply.find(params[:id])
		end
	end
