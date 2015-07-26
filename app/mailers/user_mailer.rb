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

  #实训项目邀请成员
  #user_project：邀请的数据
  def invite_member(user_project)
    @user = user_project.user
    @project = user_project.project

    #生成邮件反馈路径
    @agree = Des.encode "#{user_project.id},#{user_project.updated_at}"

    mail(
      to: @user.email, 
      subject: "[核桃网]邀请您加入(" + @project.name + ")实训项目"
      )
  end
end
