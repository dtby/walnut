class Wechat::AppliesController < Wechat::ApplicationController
	before_action :set_applies, only: [:index, :destroy]
	before_action :set_apply, only: [:show, :edit, :update, :destroy]
	before_action :valid_train_name, only: [:create, :update]
	def home
		log = Logger.new(File.join Rails.root, 'log/client_weixin.log')
		log.info $client
		$client = WeixinAuthorize::Client.new("wx3e31dd477d4c537b", "66c799d0cc42a282d4d79e596f96b0ec")
		log.info "————————————————————————————————————————————"
		log.info $client
	end

	def new
		@apply = Apply.new
	end

	def create
		@apply = Apply.valid_create(apply_params, 0)
		if @apply == 'present'
			redirect_to wechat_error_path
			flash[:notice] = "您已报名过《#{params[:train_name]}》了<br>请不要重复报名或者报名其他课程"
		elsif @apply.save
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
		update_apply = @apply.valid_create_or_update(apply_params, 1)
		if update_apply == 'present'
			redirect_to wechat_error_path
			flash[:notice] = "您已报名过《#{params[:train_name]}》了<br>请不要重复报名或者报名其他课程"
		elsif update_apply
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

		#判断是否已存在报名课程
		def valid_train_name
			if Apply.find_by_train_name(params[:train_name]).present?
				redirect_to wechat_error_path
				flash[:notice] = "您已报名过《#{params[:train_name]}》了<br>请不要重复报名或者报名其他课程"
			end
		end
	end