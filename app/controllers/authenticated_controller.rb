class AuthenticatedController < ApplicationController
  before_action :require_user

  private

  def require_user
    if !current_user
      redirect_to new_login_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
