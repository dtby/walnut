class TrainingPlatform::AnnouncesController < TrainingPlatform::ApplicationController
	before_action :set_announce, only: [:show, :edit, :destroy, :update]
	before_action :set_announces, only: [:index, :create, :update, :show]
	before_action :set_project

	def index		
	end

	def new
		@announce = Announce.new
		respond_with @announce
	end

	def create
		@project = Project.find(params[:project_id])   
		@announce = @project.announces.new(announce_params)
		@announce.user_id = current_user.id   

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
		else
			render :edit
		end
	end

	def destroy
		respond_with @announce.destroy
	end

	private
	def announce_params
		params.require(:announce).permit(:title, :description, :project_id)
	end

	def set_announce
		@announce = Announce.find(params[:id])
	end 

	def set_announces
		@announces = Announce.where(project_id: params[:project_id]).order(created_at: :DESC)
	end
end
