class UserRecruitmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  respond_to :js, :json

  def create

    #投递记录保存
    @user_recruitment = UserRecruitment.find_or_initialize_by(user_id: current_user.id, recruitment_id: params[:recruitment_id]) 
    @user_recruitment.deliver_time = Time.now
    @user_recruitment.save
    
    #邮件发送
    UserMailer.send_recruitment(current_user, @user_recruitment).deliver_later
    respond_with  @user_recruitment
  end

  #hr反馈
  def agree
    ps = (Des.decode params[:r]).split(",")
    #解密失败
    if ps.blank?
      @success = false
      @info = "无效链接"
    else
      @user_recruitment = UserRecruitment.where(id: ps[0], updated_at: ps[1]).first

      if @user_recruitment.blank?
        @success = false
        @info = "链接失效"
      else
        @user_recruitment.update(state: ps[2])
        @success = true
        @info = "操作成功"
      end
    end

    respond_with @success, @info, @user_recruitment
  end

end
