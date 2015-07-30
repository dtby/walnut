module TrainingPlatform
  class CoursesController < TrainingPlatform::ApplicationController
    def index
      @project = Project.find(params[:project_id])
    	@search = Course.search do
        if params[:q].blank?
          return render js: "$('#error-info').html('* 请输入检索条件!');"
        end
        keywords(params[:q])
	    end
    	respond_to do |format|
    		format.js
    	end
    end
  end
end