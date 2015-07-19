class UserController < ApplicationController
  before_action :authenticate_user!

  def index
    
  end

  def show
    @user = current_user
  end

  def create
    
  end

  def update
    @user = User.where(id: params[:id]).first
    #头像赋值
    if params[:user][:image]
      #头像处理,未上传头像显示默认图片
      @user.image = Image.new if @user.image.blank?
      @user.image.avatar = params[:user][:image] 
    end
    if @user.update user_params
      #头像更新
      @user.image.save(:validate => false)  if params[:user][:image]

      #更新成功
      #重新登录更新session以及current_user等相关变量方法的值 
      sign_in(:user, @user)

      flash[:notice] = "个人资料更新成功"

      redirect_to  user_path
    else
      render 'show'
    end
    @departments = [ "艺术设计系", "商务管理系", "商务管理系" ]
    @majors = [ "设计", "艺术", "艺术设计" ]
  end

  def my_recruits
    @recruits = current_user.recruitments.page(params[:page])
  end

   private
  def user_params
      params.require(:user).permit(:nickname, :name, :department, :major, :mobile, :email, :gender, :signature, :password)
    end
end
