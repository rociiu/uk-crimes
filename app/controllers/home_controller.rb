class HomeController < ApplicationController
  def index
    crimes = Crime.filter(params)
    load_form_select_data
    load_line_chart_data(crimes)
    load_bubble_chart_data(crimes)
    load_top_bar_chart_data
    load_pie_chart_data
  end

  private

  def load_form_select_data
    @years            = 2013..2014
    @forces           = Force.all.unshift(OpenStruct.new(name: 'All Forces'))
    @crime_categories = CrimeCategory.all

    params[:year] ||=  '2014'
    params[:force] ||= 'All Forces'
    params[:crime_category] ||= 'All crime'
  end

  def load_line_chart_data(crimes)
    @line_data = crimes.select("split_part(month, '-', 2) as m, count(*) as count").group("month").order("m").map {|c| [c.m, c.count] }
  end

  def load_bubble_chart_data(crimes)
    @bubble_data = crimes.select("reported_by, count(*) as count").group("reported_by").map {|c|
      force = Force.find_by(name: c.reported_by)
      { force: c.reported_by, count: c.count, lat: force.try(:lat), lon: force.try(:lon) }
    }
  end

  def load_top_bar_chart_data
    @bubble_data
  end

  def load_pie_chart_data
    @bubble_data
  end
end
