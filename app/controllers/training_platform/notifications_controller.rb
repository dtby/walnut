module TrainingPlatform
  class NotificationsController < TrainingPlatform::ApplicationController
  	before_action :set_project

  	def validate
      user = User.find_by(name: params[:user_name])
      if params[:user_name].blank?
        return render js: "$('#error-info').html('* 请输入用户名!');"
      end
      if user.blank?
        return render js: "$('#error-info').html('* 用户不存在!');"
      end
      user_project = UserProject.where(project_id: @project, user_id: user.id)
      if user_project.present?
        return render js: "$('#error-info').html('* 该用户已被邀请!');"
      end
      if user.mobile == current_user.mobile
        return render js: "$('#error-info').html('* 用户不能邀请自己!');"
      end
  		@notification = Notification.new(project_id: @project.id, content: "#{user.name}, 您好, 您被邀请参与[ #{@project.name} ]项目。", category: 1)
  		@notification.save
			@notification.generate_user_notification(user)
			UserProject.create(user_id: user.id, project_id: @project.id, role: 2, invite: false)
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
