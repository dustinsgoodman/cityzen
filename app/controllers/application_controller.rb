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
      flash[:notice] = "Please log in to continue"
      redirect_to login_path
      return false
    end
  end

  def require_no_user
    if logged_in?
      return false
    end
  end

  def keep_location
    flash.keep(:return_to)
  end

  def redirect_to_referrer_or(default, *args)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def search(opts = {})
    page = opts[:page] || 1
    per_page = opts[:per_page] || 25
    order = "_score:desc"

    search_params = {
      :query => params[:query],
      :index => params[:index],
      :type => params[:type],
      :page => page,
      :per_page => per_page,
      :order => order,
      :format => :active_record,
      :model_scope => if params[:type] == "legislation"
                        Legislation
                      elsif params[:type] == "petition"
                        Petition
                      else
                        Post
                      end
    }

    res = SiteSearch.search(search_params)
    @results = res[:records]

    respond_to do |format|
      format.html do
        render :action => 'index', :status => return_code
      end
      format.xml  { render :xml => @results }
    end
  end
end
