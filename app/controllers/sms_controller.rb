class SmsController < ApplicationController
  respond_to :js, :json

  def create
    @sms = Sms.find_or_initialize_by sms_params
    #保存验证码到数据库
    @success = @sms.send_sms
    respond_with @sms,@success
  end

  private
    def sms_params
      params.require(:sms).permit(:mobile)
    end
end
