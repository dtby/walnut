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
    if @user.update user_params
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
