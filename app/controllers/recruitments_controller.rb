class RecruitmentsController < ApplicationController
  def index
    #@recruitments = Recruitment.all
    @recruitments = Recruitment.order("created_at DESC").page(params[:page]).per(15)
  end
  def show
    @recruitment = Recruitment.find(params[:id])
    @recruitment.update(view_count: @recruitment.view_count.present? ? (@recruitment.view_count + 1) : 1) 
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