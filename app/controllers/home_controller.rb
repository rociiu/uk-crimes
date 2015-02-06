class HomeController < ApplicationController
  def index
    @crimes = Crime.filter(params)
  end
end
