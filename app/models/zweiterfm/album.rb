module Zweiterfm
  class Album
    include ActiveModel::Conversion

    attr_reader :tracks
    attr_reader :cover_url

    def initialize(tracks, cover_url)
      @tracks = tracks
      @cover_url = cover_url
    end
  end
end
