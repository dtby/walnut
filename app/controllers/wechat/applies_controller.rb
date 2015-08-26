class Wechat::AppliesController < Wechat::ApplicationController
	before_action :is_subscriber?, only: [:home]
	def home
	end

	def new
		@apply = Apply.new
	end

	def create
		@apply = Apply.new(apply_params)
		if @apply.save
			redirect_to wechat_apply_path(@apply)
		else
			render :new
		end
	end

	def show
		@apply = Apply.find(params[:id])
	end

	def index
		@applies = Apply.where(openid: session[:openid])
	end

	def destroy
		@apply = Apply.find(params[:id])
		@apply.destroy
		redirect_to wechat_applies_path
	end

	def error
	end

	private
		def apply_params
			params.require(:apply).permit(:openid, :name,  :sex, :phone, :email, :qq, :address, :situation, :degree, :way, :train_name, :school_name)
		end

		def is_subscriber?
			if params[:openid].present?
				session[:openid] = params[:openid]
			else
				redirect_to wechat_error_path
			end
		end
	end
