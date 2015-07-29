module TrainingPlatform
  class CoursesController < TrainingPlatform::ApplicationController
    def index
    	@search = Course.search do
	      keywords(params[:q])
	    end
    	respond_to do |format|
    		format.js
    	end
    end
  end
end