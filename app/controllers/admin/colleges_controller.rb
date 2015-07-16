module Admin
  class CollegesController < ApplicationController
    before_action :set_college, only: [:edit, :update, :destroy]
    def index
      @colleges = College.page(params[:page]).per(10)
    end

    def new
      @college = College.new
    end

    def create
      @college = College.new(college_params)
      if @college.save
        flash.now[:notice] = "创建成功"
        return redirect_to admin_colleges_url
      else
        return render :new
      end
    end

    def edit
    end

    def update
      if @college.update(college_params)
        flash.now[:notice] = "更新成功"
        return redirect_to admin_colleges_url
      else
        return :update
      end
    end

    def destroy
      @college.destroy
      return redirect_to admin_colleges_url
    end

    def show
    end

    private

    def college_params
      params.require(:college).permit(:name, :deleted_at)
    end
    def set_college
      @college = College.find(params[:id])
    end
  end
end