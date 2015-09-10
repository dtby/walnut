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
    #@recruits = current_user.recruitments.page(params[:page])
    @recruits = Recruitment.select("recruitments.*,user_recruitments.state as state")
    .joins("left join user_recruitments on recruitments.id = user_recruitments.recruitment_id")
    .includes(:company).where("user_recruitments.user_id = #{current_user.id}").order("user_recruitments.created_at DESC,recruitments.id ASC").page(params[:page])
  end

  #我的消息
  def my_messages
    @user_notifications = current_user.user_notifications.includes(:notification).order("created_at DESC").page(params[:page])
  end

  def my_impression
    @user = User.where(id: current_user.id).first
    @comments = @user.root_comments
              .order(created_at: :DESC)
              .page(params[:page])
  end

  #我项目
  def my_projects
    @join_projects = Project.list_projects "join"
    @create_projects = Project.list_projects "create"
  end

  def home
    @user = User.where(id: params[:id]).first
  end

  def comment
    @user = User.where(id: params[:id]).first
    @comments = @user.root_comments
              .order(created_at: :DESC)
              .page(params[:page])

  end

  def comment_user
    @user = User.where(id: params[:id]).first

    @comment = Comment.build_from(@user, current_user.id, params[:body])
    
    @comment.save

     if params[:parent_id].present?
      parent_comment = Comment.where(id: params[:parent_id]).first
      @comment.move_to_child_of(parent_comment) 
    end
    
    # redirect_to comment_user_path(@user)
    @comments = @user.root_comments
              .order(created_at: :DESC)
              .page(params[:page])
              
    respond_with(@comments)
  end
  
  #添加标签
  def tag
    if params[:tag].present?
      @user = User.where(id: params[:id]).first
      @user.tag_list.add(params[:tag] ) 
      @user.save
    end
     
    respond_with @user
  end

  #删除标签
  def remove
    if params[:tag].present?
      @user = User.where(id: params[:id]).first
      @user.tag_list.remove(params[:tag] ) 
      @user.save
    end
    # redirect_to my_impression_user_index_path
    respond_with @user
  end

  def infos
    @user = User.where(id: params[:id]).first
  end

  def my_trains
    
  end

  def impression
    
  end

  private
    def user_params
      params.require(:user).permit(:nickname, :name, :department, :major, :mobile, :email, :gender, :signature, :password, :tag_list)
    end
end
