class RecruitmentsController < ApplicationController
  def index
    if current_user.present?
      @recruitments = Recruitment.recruits.select("recruitments.id,name,city,publish_time,company_id,browse_count,user_recruitments.state as state")
      .joins("left join user_recruitments on recruitments.id = user_recruitments.recruitment_id and user_recruitments.user_id = #{current_user.try(:id)}")
      .includes(:company).order("recruitments.publish_time DESC").page(params[:page])
      @search = @recruitments.search do
        fulltext(params[:q]) do
          fields(:company, :name)
        end
        all do
          fulltext params[:category], :fields => :category
          fulltext params[:city], :fields => :city
        end
      end
    else
      @recruitments = Recruitment.recruits.select("recruitments.id,name,city,publish_time,company_id,browse_count,user_recruitments.state as state")
      .joins("left join user_recruitments on recruitments.id = user_recruitments.recruitment_id")
      .includes(:company).order("recruitments.publish_time DESC").page(params[:page])
      @search = @recruitments.search do
        fulltext(params[:q]) do
          fields(:company, :name)
        end
        all do
          fulltext params[:category], :fields => :category
          fulltext params[:city], :fields => :city
        end
      end
    end
    #@recruitments = Recruitment.all
    #@recruitments = Recruitment.includes(:company).order("created_at DESC").page(params[:page])
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
    @recruitment.update_attributes({browse_count: @recruitment.browse_count + 1}) 
  end

  def recommend
    if current_user.present?
      @recruitments = Recruitment.practices.select("recruitments.id,name,city,publish_time,company_id,browse_count,user_recruitments.state as state")
      .joins("left join user_recruitments on recruitments.id = user_recruitments.recruitment_id and user_recruitments.user_id = #{current_user.try(:id)}")
      .includes(:company).order("recruitments.publish_time DESC").page(params[:page])
      @search = @recruitments.search do
        fulltext(params[:q]) do
          fields(:company, :name)
        end
        all do
          fulltext params[:category], :fields => :category
          fulltext params[:city], :fields => :city
        end
      end
    else
      @recruitments = Recruitment.practices.select("recruitments.id,name,city,publish_time,company_id,browse_count,user_recruitments.state as state")
      .joins("left join user_recruitments on recruitments.id = user_recruitments.recruitment_id")
      .includes(:company).order("recruitments.publish_time DESC").page(params[:page])
      @search = @recruitments.search do
        fulltext(params[:q]) do
          fields(:company, :name)
        end
        all do
          fulltext params[:category], :fields => :category
          fulltext params[:city], :fields => :city
        end
      end
    end
  end
end