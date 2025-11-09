module Zweiterfm
  class PastGigs
    attr_reader :setlists
    attr_reader :songs

    def initialize(user)
      sleep 1
      @client = Setlistfm.new(Rails.application.credentials.setlistfm_api_key)
      @setlists = parse_response_body(@client.user_attended(user).body)
      @songs = @setlists.map(&:songs).flatten.uniq
    end

    private

    def parse_response_body(body)
      gigs = body.setlist.reverse.select do |setlist|
        setlist.artist["mbid"] == RADIOHEAD_MBID
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
