class Wechat::AppliesController < Wechat::ApplicationController
	before_action :is_subscriber?
	before_action :set_applies, only: [:index, :destroy]
	def home
	end
	#报名统计
	def data
		@applies = Apply.all
		@ioses = Apply.ios_class
		@androids = Apply.android_class
		@webs = Apply.web_class
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
		else
			respond_with @apply
		end
	end

	def show
		@apply = Apply.find(params[:id])
	end

	def index
	end

	def destroy
		@apply = Apply.find(params[:id])
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

		def is_subscriber?
			if session[:openid].present?
				
			elsif params[:openid].present?
				session[:openid] = params[:openid]
			else
				redirect_to wechat_error_path
			end
		end
	end
