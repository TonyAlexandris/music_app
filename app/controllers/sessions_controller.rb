
class SessionsController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        user = User.find_by_credentials(@user.email, @user.password)
        if user
            user.reset_session_token!
            session[:session_token] = user.session_token
            redirect_to user_url(current_user)
        else
            flash.now[:errors] = ["Invalid email and/or password"]
            render :new
        end
    end

    def destroy
        user = current_user
        if user
            user.reset_session_token!
            session[:session_token] = nil
            redirect_to new_session_url
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end

end