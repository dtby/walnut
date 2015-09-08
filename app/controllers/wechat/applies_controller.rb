class Wechat::AppliesController < Wechat::ApplicationController
	before_action :set_applies, only: [:index, :destroy]
	before_action :set_apply, only: [:show, :edit, :update, :destroy]
	def home
	end

	def new
		#查询已报名课程
		@train_names = Apply.where(openid: session[:openid]).pluck(:train_name)
		if @train_names.present?
			redirect_to wechat_applies_path(source: 'applied')
		else
			@apply = Apply.new
		end
	end

	def create
		@apply = Apply.new(apply_params)
		if @apply.save
			respond_to do |format|
				format.js {render js: "location.href='#{ success_wechat_applies_path(id: @apply.id)}'"}
			end
		else
			respond_with @apply
		end
	end

	def edit
		@train_names = Apply.where(openid: session[:openid]).where.not(train_name: Apply.train_names[@apply.train_name]).pluck(:train_name)
	end

	def update
		if @apply.update(apply_params)
			respond_to do |format|
				format.js {render js: "location.href='#{ wechat_apply_path(@apply, source: 'edit')}'"}
			end
		else
			respond_with @apply
		end
	end

	def show
		if params[:source] == 'edit'
			flash.now[:notice] = "您好，#{@apply.name} <br>你已经修改成功，请耐心等待<br>我们将尽快和您联系"
		else
			flash.now[:notice] = "以下是你的报名详细信息<br>如有错误，可点击修改"
		end
	end

	def index
		if params[:source] == 'applied'
			flash.now[:notice] = "您已经报过名啦！"
		else
			flash.now[:notice] = ""
		end
	end

	def destroy
		if @apply.present?
			@apply.destroy
			respond_with @apply
		end
	end

	def error
	end

	def success
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
