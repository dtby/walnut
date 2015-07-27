class TrainingPlatform::AnnouncesController < TrainingPlatform::ApplicationController
  before_action :set_announce, only: [:show, :edit, :destroy]
  before_action :set_project

  def index
  	@announces = Announce.all
  end

  def new
  	@announce = Announce.new
  end

  def show
  	
  end

  def create
  	@announce = Announce.create(announce_params)
  	if @announce.save
  		flash[:notice] = "公告创建成功"
  	end
  	respond_with @announce
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
