class HomeController < ApplicationController
  before_action :set_user
  before_action :set_tour
  before_action :set_discography

  def index
    @setlists = @tour.setlists
    @songs = @tour.songs
    @albums = @discography.albums
  end

  private

  def set_tour
    @tour = Zweiterfm::Tour.new
  end

  def set_discography
    @discography = Zweiterfm::Discography.new
  end
end
