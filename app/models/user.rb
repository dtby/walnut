# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  mobile                 :string(255)      default(""), not null
#  nickname               :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  attr_accessor :sms #短信验证码
  acts_as_voter


  validates :mobile, presence: true, uniqueness: true, on: :create
  validate :mobile_reg?, on: :create
  #validates :nickname, presence: true, length: {minimum: 3, maximum: 50}
  validates :sms, presence: true, on: :create
  validate :is_right_sms?, if: "sms.present?", on: :create
  validates :name, presence: true



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
