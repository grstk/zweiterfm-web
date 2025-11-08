class SpotifyController < ApplicationController
  before_action :set_user, only: :create_playlist

  def authenticate
    info = request.env["omniauth.auth"]["info"]
    info.except!("images")
    session[:spotify_user] = { credentials: request.env["omniauth.auth"]["credentials"], info: info }
    redirect_to root_path
  end

  def create_playlist
    playlist = Zweiterfm::Playlist.new(@spotify_user, params[:songs])
    playlist.create!

    redirect_to root_path
  end
end
