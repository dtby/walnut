class Wechat::AppliesController < Wechat::ApplicationController
	def home
		if  params[:openid].nil?
			render wechat_error_path
		end
	end

	def new
		@student = Student.new
	end

	def create
		@student = Student.new(student_params)
		if @student.save
			redirect_to :index
		else
			render :new
		end
	end

	def show
		
	end

	def index
		
	end

	def error
		
	end

	private
	 def student_params
	 	params.require(:student).permit(:phone, :email, :qq)
	 end
end
