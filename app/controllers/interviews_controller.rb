class InterviewsController < ApplicationController
  def index
    #@interviews = Interview.all
    @interviews = Interview.order("created_at DESC").page(params[:page])
  end
  def show
    @interview = Interview.select("interviews.*")
    @interview = Interview.find(params[:id])
    @interview.update(view_count:@interview.view_count.present? ? (@interview.view_count + 1) :1) 
  end
end
