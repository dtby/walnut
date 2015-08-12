module TrainingPlatform::UsersHelper
	def current_user_project project
		UserProject.where(role: 1, project_id: project.id).first
	end
end
