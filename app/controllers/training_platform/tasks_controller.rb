class TrainingPlatform::TasksController < TrainingPlatform::ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :show]
  before_action :set_project

  def index
  end

  def new
    @task = Task.new
    respond_with @task
  end

  def create
    @task = Task.new task_params
    @task.project_id = params[:project_id]
    if @task.save
      flash[:notice] = "任务创建成功"
      UserTask.create(user_id: params[:task][:user_id], task_id: @task.id, role: 1) if params[:task][:user_id].present? #指定负责人
    end
    respond_with @task
  end

  def edit
  end

  def update
  end

  def show
    respond_with @task
  end

  #任务状态变更
  def aasm_state
    @task = Task.where(id: params[:task_id]).first

    if @task.blank? 
      flash[:notice] = "当前数据不存在"
      if request.xhr?
        respond_to do |format|
          format.js {render js: "location.href='#{training_platform_project_announces_path(project_id: @project.id)}'"}
        end
      else
        return redirect_to training_platform_project_announces_path(project_id: @project.id)
      end
    end

    #更新状态
    state = params[:state]
    if @task.try(:send, "may_#{state}?")
      @task.send "#{state}!"
      @task_category = @task.task_category
    end
    respond_with @task, @task_category
  end

  private 
    def task_params
      params.require(:task).permit(:name, :description, :task_category_id)
    end

    def set_task
      @task = Task.where(id: params[:id]).first
      if @task.blank? 
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
