module Zweiterfm
  class Tour
    attr_reader :setlists
    attr_reader :songs
    attr_reader :current_gig

    def initialize(method_name = :artist_setlists, method_argument = RADIOHEAD_MBID)
      @client = Setlistfm.new(Rails.application.credentials.setlistfm_api_key)

      response = Rails.cache.fetch("#{method_name}_#{method_argument}") do
        @client.public_send(method_name, method_argument)
      end

      @setlists = parse_response_body(response.body)
      @songs = @setlists.map(&:songs).flatten.uniq
      Rails.cache.write("#{method_name}_#{method_argument}", response, expires_at: cache_expiration_time)
    end

    # def flat_setlists
    #   @setlists.map do |setlist|
    #     [setlist.date, setlist.songs]
    #   end.flatten
    # end

    def current_gig
      @setlists.select(&:now_playing?).first
    end

    def now_playing?
      current_gig.present?
    end

    def now_playing
      current_gig.now_playing
    end

    private

    def cache_expiration_time
      return 30.seconds.from_now if now_playing?
      next_gig.present? ? next_gig.time : 1.hour.from_now
    end

    def next_gig
      @setlists.select do |setlist|
        setlist.time.future?
      end.first
    end

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
