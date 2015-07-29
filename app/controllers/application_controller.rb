require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :js, :json

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user

  # 将当前用户传递到Model中
    def set_current_user
      User.current = current_user
    end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:sms, :email, :nickname ]
    end
    
end
