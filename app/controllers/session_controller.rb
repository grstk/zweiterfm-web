class SessionController < ApplicationController
  def authenticate
    session[:spotify_user] = request.env["omniauth.auth"]["credentials"]
    redirect_to root_path
  end
end
