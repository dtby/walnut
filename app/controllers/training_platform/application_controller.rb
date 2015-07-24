class TrainingPlatform::ApplicationController < ApplicationController
  before_action :authenticate_user!
  layout 'training_platform'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

end
