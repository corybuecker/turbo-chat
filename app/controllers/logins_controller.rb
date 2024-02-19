class LoginsController < ApplicationController
  before_action :reset_session

  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    email = auth.extra.id_info.email
    email_verified = auth.extra.id_info.email_verified

    user = User.find_by(email: email)
    if !email_verified || !user
      render status: 404
      return
    end

    session[:user_id] = user.id
    redirect_to chats_path
  end
end
