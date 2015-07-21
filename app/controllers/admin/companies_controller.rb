module Admin
  class CompaniesController < Admin::ApplicationController
    before_action :find_company, only: [:edit, :update, :destroy]
    def new
      @company = Company.new
    end
    def create
      @company = Company.new(company_params)
     
      if @company.save
        flash.now[:notice] = "创建成功"
        return redirect_to admin_companies_url
      else
        return render :new
      end
  
    end
    def index
      @companies = Company.page(params[:page]).per(10)
    end
    def edit
      
    end
    def update
      if @company.update(company_params)
        flash.now[:notice] = "更新成功"
        redirect_to admin_companies_path
      else
        render :update
      end
    end
    def destroy
      @company.destroy
      return redirect_to admin_companies_url
    end
def show
  
end

    private

    def company_params
      params.require(:company).permit(:name, :description, :address, :web_address, :contact_phone, :contact)
    end
    def find_company
      @company = Company.find(params[:id])
    end
  end
end