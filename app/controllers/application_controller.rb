class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  check_authorization
  rescue_from CanCan::AccessDenied do |exception|
    if exception.action == :new and exception.subject == Package
      redirect_to root_url, :alert => "Please sign in to add a new module."
    else
      redirect_to root_url, :alert => exception.message
    end
  end
  private

  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
  end
  helper_method :permitted_params

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
