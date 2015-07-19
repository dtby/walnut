class UserRecruitmentsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js, :json

  def create

    #投递记录保存
    @user_recruitment = UserRecruitment.new 
    @user_recruitment.user_id = current_user.id
    @user_recruitment.recruitment_id = params[:recruitment_id]
    @user_recruitment.save
    
    #邮件发送
    UserMailer.send_recruitment(current_user, Recruitment.where(id: params[:recruitment_id]).first).deliver_later
    respond_with  @user_recruitment
  end

end
