class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  attr_accessor :sms #短信验证码


  validates :mobile, presence: true
  validate :mobile_reg?
  validates :nickname, presence: true, length: {minimum: 3, maximum: 50}
  validates :sms, presence: true
  validate :is_right_sms?, if: "sms.present?"


  def mobile_reg?
    reg = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/
    if not mobile.match reg
      errors.add(:mobile, :mobile_reg)
    end
  end

  def is_right_sms?
    if ! Sms.is_right_sms? mobile, sms
      errors.add(:sms, :sms_error)
    end
  end
  
end
