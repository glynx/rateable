class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def current_user
    User.find_by_id(params[:user_id]) || User.find_by_id(session[:user_id])
  end

  def login 
    session[:user_id] = params[:user_id]
    render :text => "logged in as #{current_user ? current_user.email : "nil"}"
  end

  def logout
    session[:user_id] = nil
    render :text => "logged out"
  end

end
