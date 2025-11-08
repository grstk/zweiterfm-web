module Zweiterfm
  class Playlist
    attr_reader :tracks

    def initialize(user, titles)
      @user = user
      @tracks = titles.map do |title|
        select_track(title)
      end
    end

    def create!
      playlist = @user.create_playlist!("Radiohead 2025")
      playlist.add_tracks!(@tracks)
    end

    private

    def select_track(title)
      results = RSpotify::Track.search("#{title} artist:Radiohead")

      tracks =  results.select do |track|
        track.name.include?(title.split.first)
      end

      live_tracks = tracks.select do |track|
        track.name.include?("Live") || track.name.include?("live")
      end

      remastered_tracks = tracks.select do |track|
        track.name.include?("Remastered")
      end

      selection = live_tracks.first || remastered_tracks.first || tracks.first
      selection
    end
  end
end
