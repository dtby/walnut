class Wechat::AppliesController < Wechat::ApplicationController
	before_action :set_applies, only: [:index, :destroy]
	def home
		log = Logger.new(File.join Rails.root, 'log/client_weixin.log')
		log.info $client
		$client = WeixinAuthorize::Client.new("wxe3605f6d3f8d52e1", "a5fde3f35e9ee6ade3e12b6eaeecaa70")
		log.info "123333333333333"
		log.info $client
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
	end
