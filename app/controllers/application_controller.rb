class ApplicationController < ActionController::Base
  before_filter :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private
    def require_login
      unless current_user
        flash.now[:warning] = "You do not current have access to this page. Contact administration for help."
        redirect_to login_url
      end
    end
end
