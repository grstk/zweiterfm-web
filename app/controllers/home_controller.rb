class HomeController < ApplicationController
  before_action :set_tour

  def index
    @setlists = @tour.setlists
    @songs = @tour.songs
  end

  private

  def set_tour
    @tour = Zweiterfm::Tour.new
  end
end
