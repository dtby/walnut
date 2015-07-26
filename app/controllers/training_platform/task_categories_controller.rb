class TrainingPlatform::TaskCategoriesController < TrainingPlatform::ApplicationController
  before_action :set_task_category, only: [:edit, :update, :destroy]
  before_action :set_project

  def new
    @task_category = TaskCategory.new
    respond_with @task_category
  end

  def create
    @task_category = TaskCategory.new task_category_params
    @task_category.project_id = params[:project_id]
    if @task_category.save
      flash[:notice] = "任务列表创建成功"
    end
    respond_with @task_category
  end


  def edit
    respond_with @task_category
  end

  def update
    @task_category = params[:project_id]
    @task_category.update project_params
    respond_with @task_category
  end

  def destroy
    respond_with @task_category.destroy
  end

  private

    def task_category_params
      params.require(:task_category).permit(:name, :description)
    end

    def set_task_category
      @task_category = TaskCategory.where(id: params[:id]).first
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
