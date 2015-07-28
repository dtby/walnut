class UserProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_project

  def invited
  	@user_project.update(invite: true)
  	return redirect_to my_messages_user_index_path
  end

  def uninvited
  	@user_project.update(invite: false)
  	return redirect_to my_messages_user_index_path
  end

  private
  def set_user_project
  	@user_project = UserProject.find(params[:id])
  end
end