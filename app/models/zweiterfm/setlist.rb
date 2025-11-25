module Zweiterfm
  class Setlist
    include ActiveModel::Conversion

    attr_reader :time
    attr_reader :venue
    attr_reader :city
    attr_reader :songs

    def initialize(date, city, venue, songs)
      @time = Date.parse(date).to_time.change(hour: 20, min: 30)
      @city = city
      @venue = venue
      @songs = songs
    end

    def now_playing
      return unless now_playing?
      @songs.last
    end

    def now_playing?
      time.today? && time.past?
    end
  end
end
