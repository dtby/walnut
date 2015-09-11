module Admin
	class ProfessionsController < Admin::ApplicationController
		def index
			@professions = Profession.page(params[:page]).per(10)
		end
	end
end