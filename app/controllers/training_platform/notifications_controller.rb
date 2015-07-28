module TrainingPlatform
  class NotificationsController < TrainingPlatform::ApplicationController
  	before_action :set_project

  	def validate
  		user = User.find_by(name: params[:user_name])
  		@notification = Notification.new(project_id: @project.id, content: "#{user.name}, 您好, 您被邀请参与#{@project.name}项目, 请前往个人中心查看。")
  		@notification.save
  		if user.blank?
  			return render js: "$('#error-info').html('* 用户不存在');"
  		else
  			@notification.generate_user_notification(user)
  			UserProject.create(user_id: user.id, project_id: @project.id, role: 3, invite: false)
  		end
  		respond_to do |format|
  			format.js
  		end
  	end

  	private

  	def set_project
  		@project = Project.find(params[:project_id])
  	end
  end
end
