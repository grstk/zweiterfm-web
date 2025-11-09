module Zweiterfm
  class Album
    include ActiveModel::Conversion

    attr_reader :title
    attr_reader :tracks
    attr_reader :cover_url
    attr_reader :color

    def initialize(options = {})
      @title = options[:title]
      @tracks = options[:tracks]
      @cover_url = options[:cover_url]
      @color = options[:color]
    end
  end
end
