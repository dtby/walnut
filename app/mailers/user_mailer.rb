class UserMailer < ApplicationMailer
 
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
