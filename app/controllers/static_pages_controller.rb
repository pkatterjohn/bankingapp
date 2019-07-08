class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to home_user_path(current_user)
    end
  end
end
