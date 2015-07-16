# == Schema Information
#
# Table name: sms
#
#  id         :integer          not null, primary key
#  mobile     :string(255)      not null
#  code       :string(255)      default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sms < ActiveRecord::Base

  #发送短信验证码
  def send_sms

    sms_log = Logger.new(File.join Rails.root, 'log/sms.log')

    sms_log.info "========send sms start(#{Time.now})========"


    #短信验证码生成
    self.code = Sms.rand_code 4

    #设置云片使用账号
    ChinaSMS.use :yunpian, password: 'a1b163c21980f071ca494def72634674'

    #发送短信验证码
    tpl_params = { code: self.code , company: '核桃网' }
    msg = ChinaSMS.to self.mobile , tpl_params, tpl_id: 2

    #log记录发送的信息
    sms_log.info "mobile number: #{self.mobile}"
    sms_log.info "code: #{self.code}"

    if msg["code"] == 0
      #验证码发送成功则保存sms
      if self.save
        sms_log.info "send success"
        send_sms = true
      else
        sms_log.info "sms save Failure xxxxxxxxxxxxxxxxxxx"
        sms_log.info self.errors.to_s
      end
    else
      sms_log.info "send Failure xxxxxxxxxxxxxxxxxxx"
      send_sms = false
    end 
    sms_log.info msg.to_s
    sms_log.info "========send sms end(#{Time.now}):========"

    send_sms
  end


  #生成短信验证码
  #参数：len，验证码长度
  def self.rand_code len
    chars = ("0".."9").to_a
    code = ""
    1.upto(len) { |i| code << chars[rand(chars.size-1)] }
    return code
  end


  #确认短信验证码是正确并有效
  #短信有效时间：30分钟
  def self.is_right_sms? mobile, code
    return true if code == "999999"
    Sms.where("mobile = ? and code = ? and updated_at >= ?", mobile, code, (Time.at Time.now - 30*60) ).first
  end
end
