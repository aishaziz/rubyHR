class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    #@current_user = User.find(session[:user_id]) if session[:user_id]
    current_user = User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  def require_user
    unless current_user
      flash[:error] = "Authorization Required! You must be signed in to perform that action."
      redirect_to login_path
    end
  end 

  def require_admin
    unless current_user && current_user.admin? #fix to redirect to root if user is signed in but not admin
      flash[:error] = "Authorization Required! You must be signed in to perform that action"
      redirect_to login_path
    end
  end
end