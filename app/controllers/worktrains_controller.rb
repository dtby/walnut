class WorktrainsController < ApplicationController
	before_action :set_train, only: [:edit, :show, :update, :destroy]
  def index
  	@trains = Train.all
  end

  def show
      @train.update_views_count
  	end

  	private
		def train_params
  			params.require(:train).permit(:title, :picture_url, :introduce, :pv, :syllabus, :prospect, :characteristic)
		end

		def set_train
			@train = Train.find(params[:id])
		end
end
