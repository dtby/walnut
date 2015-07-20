class UserMailer < ApplicationMailer

  def test_send
    mail(
      from: "dev@buoyantec.com",
      to: "992273028@qq.com", 
      subject: "test send email success!!!"
      )
  end
 
  def send_recruitment(user, user_recruitment, host)
    @user = user
    @recruitment = user_recruitment.recruitment

    #生成邮件反馈路径
    agree = Des.encode "#{user_recruitment.id},#{user_recruitment.updated_at},1"
    disagree = Des.encode "#{user_recruitment.id},#{user_recruitment.updated_at},90"
    @agree_url = host + agree_user_recruitments_path(r: agree)
    @disagree_url = host + agree_user_recruitments_path(r: disagree)

    pp agree,disagree
    pp @agree_url,@disagree_url

    mail(
      from: @user.email,
      to: @recruitment.hr_email, 
      subject: @recruitment.name
      )
  end
end
