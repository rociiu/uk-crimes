class Crime < ActiveRecord::Base
  def self.filter(params)
    year       = params[:year] || '2014'
    force      = params[:force] || 'All Forces'
    crime_type = params[:crime_type] || 'All crime and ASB'
  end
end
