class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
    if logged_in?
      redirect_to home_user_path(current_user)
    end
  end

  def create
    user = User.find_by(login: params[:session][:login])
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to home_user_path(user)
      #Log In User
    else
      #create error message
      flash.now[:danger] = 'Invalid login/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
