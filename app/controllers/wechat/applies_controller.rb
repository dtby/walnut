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
			redirect_to :index
		else
			render :new
		end
	end

	def show
		@apply = Apply.find(params[:id])
	end

	def index
		@applies = Apply.where(openid: params[:openid])
	end

	def error
		
	end

	private
		def apply_params
			params.require(:apply).permit(:phone, :email, :qq)
		end

		def is_subscriber?
			if params[:openid].present?
				session[:openid] = params[:openid]
			else
				redirect_to wechat_error_path
			end
		end
	end
