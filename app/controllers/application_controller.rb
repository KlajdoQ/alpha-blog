class ApplicationController < ActionController::Base
   
    helper_method :current_user, :logged_in?, :require_user
    
   def current_user 
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
   end

   def logged_in?
      !!current_user #!! turns current user into a boolean value
   end

   def require_user 
      if !logged_in?
         flash[:alert] = "You must be logged in"
      else
         redirect_to login_path
      end
   end

end
