module Zweiterfm
  class Tour
    attr_reader :setlists
    attr_reader :songs

    def initialize(method_name = :artist_setlists, method_argument = RADIOHEAD_MBID)
      @client = Setlistfm.new(Rails.application.credentials.setlistfm_api_key)
      response = @client.public_send(method_name, method_argument)

      @setlists = parse_response_body(response.body)
      @songs = @setlists.map(&:songs).flatten.uniq
    end

    def flat_setlists
      # setlists = @setlists.select do |setlist|
      #   setlist.songs.any?
      # end

      @setlists.map do |setlist|
        [setlist.date, setlist.songs]
      end.flatten
    end

    private

    def parse_response_body(body)
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
