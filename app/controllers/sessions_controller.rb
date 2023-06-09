class SessionsController < ApplicationController
    def new

    end

    def create
       user = User.find_by(email:params[:session][:email].downcase)
       if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id # user authenticated and stays logged in 
            flash[:notice] ="Login successful"
            redirect_to user
       else
            flash.now[:alert] = "There was something wrong with your login"
            render 'new', status: :unprocessable_entity 
       end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Logged out"
        redirect_to login_path
    end
end