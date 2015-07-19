class UserMailer < ApplicationMailer

  def test_send
    mail(
      from: "dev@buoyantec.com",
      to: "992273028@qq.com", 
      subject: "test send email success!!!"
      )
  end
 
  def send_recruitment(user,recruitment)
    @user = user
    @recruitment = recruitment
    mail(
      from: user.email,
      to: recruitment.hr_email, 
      subject: recruitment.name
      )
  end
end
