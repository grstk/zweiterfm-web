module Zweiterfm
  class Discography
    attr_reader :albums

    def initialize
      @albums = RADIOHEAD_DISCOGRAPHY.map do |album|
        Zweiterfm::Album.new(album)
      end
    end
  end
end
