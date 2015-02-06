class HomeController < ApplicationController
  def index
    load_form_select_data
  end

  private

  def load_form_select_data
    @years            = 2013..2014
    @forces           = Force.all.unshift(OpenStruct.new(name: 'All Forces'))
    @crime_categories = CrimeCategory.all
  end
end
