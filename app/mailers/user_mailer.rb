class UserMailer < ApplicationMailer

  def test_send
    mail(
      to: "fwshun@163.com", 
      subject: "test send email success!!!"
      )
  end
 
  def send_recruitment(user, user_recruitment)
    @user = user
    @recruitment = user_recruitment.recruitment

    #生成邮件反馈路径
    @agree = Des.encode "#{user_recruitment.id},#{user_recruitment.updated_at},1"
    @disagree = Des.encode "#{user_recruitment.id},#{user_recruitment.updated_at},90"

    mail(
      to: @recruitment.hr_email, 
      subject: @recruitment.name
      )
  end
end
