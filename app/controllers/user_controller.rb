class UserController < ApplicationController
  before_action :authenticate_user!

  def show
  end
  def my_recruits
    @recruits = Recruitment.includes(:company).order("created_at DESC").page(params[:page])
  end
end
