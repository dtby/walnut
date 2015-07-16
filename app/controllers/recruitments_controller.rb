class RecruitmentsController < ApplicationController
  def index
    @recruitments = Recruitment.all
  end
  def show
    @recruitment = Recruitment.find(params[:id])
  end
  def create
    @recruitment = Recruitment.new(recruitment_params)

    if @recruitment.save
    redirect_to @recruitment
  else
    render 'new'
  end
  end
  def  new
    @recruitment = Recruitment.new
  end
  def edit
    
  end
  private
  def recruitment_params
      params.require(:recruitment).permit(:name, :industry, :gender, :certificate, :number, :publish_time, :degree_id, :company_id, :city, :remuneration, :foreign_language, :others)
    end
end