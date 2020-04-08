
class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            user = User.find_by_credentials(@user.email, @user.password)
            log_in_user!(user)
            render :show
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end            
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end

    