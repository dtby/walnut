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
#  name                   :string(255)
#  major                  :string(255)
#  department             :string(255)
#  gender                 :string(255)
#  signature              :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  attr_accessor :sms #短信验证码
  acts_as_voter
  
  has_many :user_recruitments, dependent: :destroy
  has_many :recruitments, through: :user_recruitments
  has_one :image, as: :imageable
  has_many :user_projects, dependent: :destroy
  
  has_many :user_tasks, dependent: :destroy 
  has_many :tasks, through: :user_tasks

  has_many :announces, dependent: :destroy 
  
  has_many :user_notifications, dependent: :destroy 
  has_many :notifications, through: :user_notifications



  validates :mobile, presence: true, uniqueness: true, on: :create
  validate :mobile_reg?, on: :create
  #validates :nickname, presence: true, length: {minimum: 3, maximum: 50}
  validates :sms, presence: true, on: :create
  validate :is_right_sms?, if: "sms.present?", on: :create
  validates :name, presence: true, on: :update

  enum department: {
  '艺术设计系': 'yssj',
  '商务管理系': 'swgl',
  '商务管理': 'swglx',
  '商务英语': 'swyy'
  }
  enum major: {
    '设计': 'sj',
  '商务': 'sw',
  '管理': 'gl',
  '英语': 'yy'
  }

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

   #页面头像显示
  def show_image
    self.image.present? ? self.try(:image).try(:avatar).try(:url, :u_202_202) : "default-user.jpg"
  end

  #显示名字
  def show_name
    name || mobile
  end


  #取得用户的（不同状态的任务)
  def principal_tasks state,project_id
    if state == "all"
      Task.includes(:user_tasks).where(user_tasks: {user_id: self.id, role: 1},tasks: {project_id: project_id})
    else
      Task.includes(:user_tasks).where(user_tasks: {user_id: self.id, role: 1},tasks: {project_id: project_id}).send(state.to_sym) rescue []
    end
  end

  #current_user在model中使用
  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

end
