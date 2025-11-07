module Zweiterfm
  class Discography
    attr_reader :albums

    def initialize
      @albums = releases.map do |release|
        Zweiterfm::Album.new(tracks(release), cover_url(release))
      end
    end

    private

    def release_groups
      @release_groups ||=
        MusicBrainz::Artist.find(RADIOHEAD_MBID).release_groups.select do |release_group|
          release_group.type == "Album"
        end
    end

    def releases
      @releases ||=
        release_groups.map do |release_group|
          # sleep 1
          select_release(release_group)
        end
    end

    def select_release(release_group)
      release_group.releases.select do |release|
        %w[ XW XE GB ].include?(release.country) && ["CD", "Digital Media"].include?(release.format)
      end.first
    end

    def cover_url(release)
    end

    def tracks(release)
      release.tracks.map(&:title)
    end
  end
end
