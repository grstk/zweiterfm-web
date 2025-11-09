module Zweiterfm
  class Album
    include ActiveModel::Conversion

    attr_reader :tracks
    attr_reader :cover_url
    attr_reader :color

    def initialize(tracks, cover_url, color)
      @tracks = tracks
      @cover_url = cover_url
      @color = color
    end
  end
end
