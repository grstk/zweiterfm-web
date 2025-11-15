module Zweiterfm
  class Discography
    attr_reader :albums
    attr_reader :tracks

    def initialize
      @albums = RADIOHEAD_DISCOGRAPHY.map do |album|
        Zweiterfm::Album.new(album)
      end

      @tracks = albums.map(&:tracks).flatten
    end
  end
end
