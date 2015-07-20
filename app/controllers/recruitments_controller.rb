class RecruitmentsController < ApplicationController
  def index
    #@recruitments = Recruitment.all
    #@recruitments = Recruitment.includes(:company).order("created_at DESC").page(params[:page])
    if current_user.present?
    @recruitments = Recruitment.select("recruitments.id,name,city,publish_time,company_id,view_count,user_recruitments.state as state")
    .joins("left join user_recruitments on recruitments.id = user_recruitments.recruitment_id and user_recruitments.user_id = #{current_user.try(:id)}")
    .includes(:company).order("recruitments.created_at DESC,recruitments.id ASC").page(params[:page])
    else
      @recruitments = Recruitment.select("recruitments.id,name,city,publish_time,company_id,view_count,user_recruitments.state as state")
      .joins("left join user_recruitments on recruitments.id = user_recruitments.recruitment_id")
      .includes(:company).order("recruitments.created_at DESC,recruitments.id ASC").page(params[:page])
    end
  end


  def show
    if current_user.present?
      @recruitment = Recruitment.select("recruitments.*,user_recruitments.state as state")
      .joins("left join user_recruitments on recruitments.id = user_recruitments.recruitment_id and user_recruitments.user_id = #{current_user.try(:id)}")
      .includes(:company).where(id: params[:id]).first
    else
      @recruitment = Recruitment.select("recruitments.*,user_recruitments.state as state")
    .joins("left join user_recruitments on recruitments.id = user_recruitments.recruitment_id")
    .includes(:company).where(id: params[:id]).first
    end
    
    @recruitment.update(view_count: @recruitment.view_count.present? ? (@recruitment.view_count + 1) : 1) 
  end

  def recommend
    if current_user.present?
      @recruitments = Recruitment.select("recruitments.id,name,city,publish_time,company_id,view_count,user_recruitments.state as state")
      .joins("left join user_recruitments on recruitments.id = user_recruitments.recruitment_id and user_recruitments.user_id = #{current_user.try(:id)}")
      .includes(:company).order("recruitments.created_at DESC,recruitments.id ASC").page(params[:page])
    else
      @recruitments = Recruitment.select("recruitments.id,name,city,publish_time,company_id,view_count,user_recruitments.state as state")
      .joins("left join user_recruitments on recruitments.id = user_recruitments.recruitment_id")
      .includes(:company).order("recruitments.created_at DESC,recruitments.id ASC").page(params[:page])
    end
  end
  
end