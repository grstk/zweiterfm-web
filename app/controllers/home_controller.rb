class HomeController < ApplicationController
  before_action :set_user
  before_action :set_tour
  before_action :set_discography

  def index
    @setlists = @tour.setlists
    @songs = @tour.songs

    if params[:setlistfm_user_name]
      past_gigs = Zweiterfm::PastGigs.new(params[:setlistfm_user_name])
      @past_setlists = past_gigs.setlists
      @past_songs = past_gigs.songs
    end

    @all_songs = @songs + (@past_songs || [])
    add_other_album
    @albums = @discography.albums
  end

  private

  def set_tour
    @tour = Zweiterfm::Tour.new
  end

  def set_discography
    @discography = Zweiterfm::Discography.new
  end

  def add_other_album
    live_songs = @songs.union(@past_songs || [])
    others = live_songs - @discography.tracks
    return if others.empty?

    @discography.albums << Zweiterfm::Album.new(title: "Other", tracks: others, color: "gray")
  end
end
