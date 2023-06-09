class UsersController < ApplicationController
    #before_action :require_user, only: [:show,:edit, :update, :destroy]
    #before_action :require_same_user, only: [:show,:edit, :update, :destroy]

    def new
        @user = User.new
    end

    def index 
        @users= User.all
    end

    def show 
        @user = User.find(params[:id])
        @articles= @user.articles
    end

    def create
        @user = User.new(user_params)
        if @user.save 
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to the Alpha Blog #{@user.username}"
            redirect_to articles_path
        else 
            render 'new', status: :unprocessable_entity 
        end
    end

    def edit 
        @user = User.find(params[:id])
    end

    def update 
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "User updated successfully"
        else
            render 'edit'
        end
    end

    def destroy
        @user=User.find(params[:id])
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "User deleted successfully"
        redirect_to articles_path
    end
    private 

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
        if current_user != @user
            flash[:alert] = "You have to be logged in"
            redirect_to @user
        end
    end
end