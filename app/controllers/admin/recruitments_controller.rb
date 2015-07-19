module Admin
  class RecruitmentsController < Admin::ApplicationController
    def new
      @recruitment = Recruitment.new
    end
    def create
      @recruitment = Recruitment.new(recruitment_params)
     
      if @recruitment.save
        flash.now[:notice] = "创建成功"
        return redirect_to admin_recruitments_url
      else
        return render :new
      end
  
    end
    def index
      @recruitments = Recruitment.page(params[:page]).per(10)
    end
    def edit
      
    end
    def update
      
    end
    def destroy
      @recruitment.destroy
      return redirect_to admin_recruitments_url
    end
def show
  
end

    private

    def recruitment_params
      params.require(:recruitment).permit(:name, :industry, :gender, :certificate, :number, :publish_time, :degree_id, :company_id, :city, :remuneration, :foreign_language, :others)
    end
  end
end