class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def set_user
    @spotify_user = nil
    return unless session[:spotify_user].present?
    @spotify_user = RSpotify::User.new(session[:spotify_user])
  end
end
