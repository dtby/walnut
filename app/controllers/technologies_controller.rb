class TechnologiesController < ApplicationController
	def index
		@technolgies = Technology.all
	end

	def show
		@technology = Technology.find(params[:id])
		@technology_stages = @technology.technology_stages
	end
end
