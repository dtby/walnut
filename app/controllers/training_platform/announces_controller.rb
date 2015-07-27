class TrainingPlatform::AnnouncesController < TrainingPlatform::ApplicationController
	before_action :set_announce, only: [:show, :edit, :destroy]
	before_action :set_project

	def index
		@announces = Announce.where(project_id: params[:project_id]).order(created_at: :DESC)
		@announce = Announce.where(project_id: params[:project_id]).last
	end

	def new
		@announce = Announce.new
		respond_with @announce
	end

	def create   
		@announce = Announce.create(announce_params)
		@announce.project_id = params[:project_id]
		@announce.user_id = current_user.id   
		@announces = Announce.where(project_id: params[:project_id]).order(created_at: :DESC)
		if @announce.save     
			respond_with @announces
		else
			render :new
		end
	end

	def show
		respond_with @announce
	end

	def edit
		respond_with @announce
	end

	def update
		if @announce.update(announce_params)
			respond_with @announce
		end
	end

	def destroy
		respond_with @announce.destroy
	end

	private
	def announce_params
		params.require(:announce).permit(:id, :title, :description, :user_id, :project_id)
	end

	def set_announce
		@announce = Announce.find(params[:id])
	end 
end
