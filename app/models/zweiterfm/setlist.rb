module Zweiterfm
  class Setlist
    include ActiveModel::Conversion

    attr_reader :date
    attr_reader :venue
    attr_reader :city
    attr_reader :songs

    def initialize(date, city, venue, songs)
      @date = date
      @city = city
      @venue = venue
      @songs = songs
    end
  end
end
