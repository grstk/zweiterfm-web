RADIOHEAD_MBID = "a74b1b7f-71a5-4011-9441-d0b5e4122711".freeze
RADIOHEAD_SPOTIFY_ID = "4Z8W4fKeB5YxbusRsdQVPb".freeze
TOUR_START = "2025-11-04".freeze

MusicBrainz.configure do |config|
  config.app_name = "zweiterfm"
  config.app_version = "0.1"
  config.contact = Rails.application.credentials.email
  config.query_interval = 1.2

  config.tries_limit = 10
  # config.cache_path = "/tmp/musicbrainz-cache"
  # config.perform_caching = true
end
