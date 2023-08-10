class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :splash_screen_action?
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    if session[:user_return_to].nil?
      groups_path
    else
      super
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password)
    end
  end

  private

  def splash_screen_action?
    params[:controller] == 'pages' && params[:action] == 'splash'
  end
end
