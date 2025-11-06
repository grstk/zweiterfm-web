class HomeController < ApplicationController
  def index
    @setlists = Zweiterfm::Setlist.setlists
  end
end
