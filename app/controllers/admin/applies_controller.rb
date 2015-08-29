module Admin
	class AppliesController < Admin::ApplicationController
		def index
			@applies = Apply.students(params[:train_name])
		end
	end
end