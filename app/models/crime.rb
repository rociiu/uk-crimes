class Crime < ActiveRecord::Base
  def self.filter(params)
    year       = params[:year] || '2014'
    force      = params[:force] || 'All Forces'
    crime_type = params[:crime_category] || 'All crime'

    relation = Crime.where("month like ?", "#{year}-%")
    relation = relation.where(reported_by: force) if force != 'All Forces'
    relation = relation.where(crime_type: crime_type) if crime_type != 'All crime'

    relation
  end
end
