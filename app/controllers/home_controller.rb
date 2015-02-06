class HomeController < ApplicationController
  def index
    load_form_select_data
    load_line_chart_data
  end

  private

  def load_form_select_data
    @years            = 2013..2014
    @forces           = Force.all.unshift(OpenStruct.new(name: 'All Forces'))
    @crime_categories = CrimeCategory.all
  end

  def load_line_chart_data
    crimes = Crime.filter(params)
    @line_data = crimes.select("split_part(month, '-', 2) as m, count(*) as count").group("month").order("m").map {|c| [c.m, c.count] }
  end
end
