class Wechat::AppliesController < Wechat::ApplicationController
	before_action :set_applies, only: [:index, :destroy]
	before_action :set_apply, only: [:show, :edit, :update, :destroy]
	before_action :set_applied, only: [:home, :new]
	def home
	end

	def new
		@apply = Apply.new
		#查询已报名课程
		@train_names = Apply.where(openid: session[:openid]).pluck(:train_name)
	end

	def create
		@apply = Apply.new(apply_params)
		if @apply.save
			respond_to do |format|
				format.js {render js: "location.href='#{ success_wechat_applies_path(id: @apply.id)}'"}
			end
			flash[:notice] = "您好，#{@apply.name} <br>你已经提交成功，请耐心等待<br>我们将尽快和您联系"
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
				format.js {render js: "location.href='#{ wechat_apply_path(@apply)}'"}
			end
			flash[:notice] = "您好，#{@apply.name} <br>你已经修改成功，请耐心等待<br>我们将尽快和您联系"
		else
			respond_with @apply
		end
	end

	def show
	end

	def index
		flash[:notice] = "以下是你的报名详细信息<br>如有错误，可点击修改"
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
		flash[:notice] = "以下是你的报名详细信息<br>如有错误，可点击修改"
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

		def set_applied
			@applied = Apply.find_by_openid(session[:openid])
			if @applied.present?
				render :home
			end
		end
	end
