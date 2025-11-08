module ApplicationHelper
  def spotify_user_authenticated?
    @spotify_user.present?
  end
end
