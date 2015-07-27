class TrainingPlatform::AnnouncesController < TrainingPlatform::ApplicationController
	before_action :set_announce, only: [:show, :edit, :destroy]
	before_action :set_project

	def index
		@announces = Announce.where(project_id: params[:project_id]).order(created_at: :DESC)
	end

	def new
		@announce = Announce.new
		respond_with @announce
	end

	def create   
		@announce = Announce.create(announce_params)
		@announce.project_id = params[:project_id]
		@announce.user_id = current_user.id   
		@announces = Announce.where(project_id: params[:project_id])
		if @announce.save     
			flash.now[:notice] = "公告创建成功"
		end   
		respond_with @announces
	end

	def show
		respond_with @announce
	end

	def edit
		respond_with @announce
	end

	def update
		if @announce.update(announce_params)
			flash[:notice] = "公告更新成功"
		end
		respond_with @announce
	end

	def destroy
		respond_with @announce.destroy
	end

	private
	def announce_params
		params.require(:announce).permit(:id, :title, :description, :user_id, :project_id)
	end

	def set_announce
		@announce = Announce.where(id: params[:id]).first
		if @announce.blank? 
			flash[:notice] = "当前数据不存在"
			if request.xhr?
				respond_to do |format|
					format.js {render js: "location.href='#{training_platform_root_path}'"}
				end
			else
				return redirect_to training_platform_root_path
			end
		end
	end 
end
