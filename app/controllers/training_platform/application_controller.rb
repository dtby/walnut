require "application_responder"
module TrainingPlatform
  class ApplicationController < ActionController::Base
    layout 'training_platform'
    self.responder = ApplicationResponder
    respond_to :html, :js, :json

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

  end
end
