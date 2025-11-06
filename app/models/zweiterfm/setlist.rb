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

    def self.setlists
      client = Setlistfm.new(Rails.application.credentials.setlistfm_api_key)
      body = client.artist_setlists(RADIOHEAD_MBID).body
      parse_response_body(body)
    end

    private

    def self.parse_response_body(body)
      gigs = body.setlist.reverse.select do |setlist|
        Date.parse(setlist.eventDate).after? Date.parse(TOUR_START) - 1
      end

      gigs.map do |gig|
        date = gig.eventDate
        venue = gig.venue.name
        city = gig.venue.city.name
        songs = gig.sets.set.map(&:song).flatten.map { |song| song["name"] }

        Setlist.new(date, city, venue, songs)
      end
    end
  end
end
