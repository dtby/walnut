class TrainingPlatform::TaskCategoriesController < TrainingPlatform::ApplicationController
  before_action :set_task_category, only: [:edit, :update, :destroy, :show]
  before_action :set_project
  before_action :set_task_categories

  def new
    @task_category = TaskCategory.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @task_category = TaskCategory.new task_category_params
    @task_category.project_id = params[:project_id]
    respond_to do |format|
      if @task_category.save
        flash[:notice] = "任务列表创建成功"
        format.js
      end
    end
  end


  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @task_category.update task_category_params
        flash[:notice] = "任务列表修改成功"
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @task_category.destroy
        flash[:notice] = "任务列表删除成功"
        format.js
      end
    end
  end

  def show
    respond_with @task_category
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task_categories
      @project = Project.find(params[:project_id])
      @task_categories = @project.task_categories
    end

    def task_category_params
      params.require(:task_category).permit(:name, :description)
    end

    def set_task_category
      @project = Project.find(params[:project_id])
      @task_category = @project.task_categories.find(params[:id])
      if @task_category.blank? 
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
