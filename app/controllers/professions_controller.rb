class ProfessionsController < ApplicationController
	def index
		@professions = Profession.all
	end

	def show
		@profession = Profession.find(params[:id])
		@profession_stages = @profession.profession_stages
	end
end
