class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_pipedrive_key

  protected 
     
    def logged_in? 
      unless session[:user_id] 
        flash[:notice] = "You need to log in first." 
        redirect_to log_in_path 
        return false 
      else 
        return true 
      end 
    end

    def current_pipedrive_key
      if @pipedrive_app_key
        @pipedrive_app_key
      elsif session[:pipedrive_key]
        @pipedrive_app_key = session[:pipedrive_key] 
      else
        @pipedrive_app_key = session[:pipedrive_key] = PipedriveConfig.find_app_key_by_user(current_user)
      end
    end

  private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
