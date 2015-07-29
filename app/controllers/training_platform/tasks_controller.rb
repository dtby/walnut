class TrainingPlatform::TasksController < TrainingPlatform::ApplicationController
  before_action :set_project
  before_action :set_task, only: [:edit, :update, :destroy, :show, :aasm_state, 
    :move_category, :tagged, :update_principal, :level]
  

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
    @task_category = @task.task_category
    respond_with @task,@task_category
  end

  #任务状态变更
  def aasm_state
    #更新状态
    state = params[:state]
    if @task.try(:send, "may_#{state}?")
      @task.send "#{state}!"
    end
    @task_category = @task.task_category
    respond_with @task, @task_category
  end

  #移动到新分类
  def move_category
    @task.update_attribute("task_category_id", params[:task_category])
    @task_category = @task.task_category
    respond_with @task, @task_category
  end

  #添加标签
  # def tagged
  #   @task.tag_list.add(params[:content] )  if params[:content].present? 
  #   @task_category = @task.task_category
  #   respond_with @task, @task_category
  # end


  #更新负责人
  def update_principal
    user_task = UserTask.find_or_initialize_by(user_id: params[:user], task_id: @task.id)
    user_task.role = "principal"
    user_task.save
    respond_with @task
  end

  #修改任务重要级别
  def level
    @task.update_attribute("level", Task.levels[params[:level]])
    respond_with @task
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
            format.js {render js: "location.href='#{training_platform_project_announces_path(project_id: @project.id)}'"}
          end
        else
          return redirect_to training_platform_project_announces_path(project_id: @project.id)
        end
      end
    end 
end
