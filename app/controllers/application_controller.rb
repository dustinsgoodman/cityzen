class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  helper_method :current_user, :current_user_session, :logged_in?, :admin?, :require_user, :keep_location
 
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def logged_in?
    !!current_user
  end

  protected

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def require_user
    unless logged_in?
      store_location
      flash[:notice] = "Please log in to continue"
      redirect_to login_path
      return false
    end
  end
  
  def require_no_user
    if logged_in?
      redirect_to account_path
      return false
    end
  end

  def keep_location
    flash.keep(:return_to)
  end
  
end