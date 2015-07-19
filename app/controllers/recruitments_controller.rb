class RecruitmentsController < ApplicationController
  def index
    #@recruitments = Recruitment.all
    #@recruitments = Recruitment.includes(:company).order("created_at DESC").page(params[:page])

    @recruitments = Recruitment.select("recruitments.id,name,city,publish_time,company_id,view_count,user_recruitments.state as state")
    .joins("left join user_recruitments on recruitments.id = user_recruitments.recruitment_id and user_recruitments.user_id = #{current_user.try(:id)}")
    .includes(:company).order("recruitments.created_at DESC,recruitments.id ASC").page(params[:page])
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