class ApplicationController < ActionController::Base
    
    helper_method :current_user

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
       current_user.session_token == session[:session_token] if current_user
    end

    def log_in_user!(user)
        user.reset_session_token!
        session[:session_token] = user.session_token
    end
    
    def send_to_login
        if !logged_in?
            flash[:log_in_first] = "Log in First"
            redirect_to new_session_url and return
        end
    end
end
