require 'csv'
require 'httparty'

namespace :import do

  def import_from_csv_file(csv_path)
    if File.exists?(csv_path)
      month = File.basename(csv_path)[/^\d{4}-\d{2}/]
      if month.present?
        Crime.where(month: month).delete_all
      end
      puts "Start importing crimes from #{csv_path}."
      ActiveRecord::Base.connection.execute("copy crimes (crime_id, month, reported_by, falls_within, lon, lat, location, lsoa_code, lsoa_name, crime_type, last_outcome_category, context) from '#{csv_path}' DELIMITERS ',' CSV HEADER;")
      puts "Done."
    end
  end

  desc "import crimes from csv"
  task :crimes => :environment do
    csv_path = ENV['CSV']
    import_from_csv_file(csv_path)
  end

  desc "import crimes from directory"
  task :crimes_directory => :environment do
    directory_path = ENV['DIR']
    Dir[File.join(directory_path, "**/*.csv")].each do |csv_path|
      import_from_csv_file(csv_path)
    end
  end

  desc "import forces"
  task :forces => :environment do
    res = HTTParty.get("http://data.police.uk/api/forces")
    res.each do |force_hash|
      Force.where(force_id: force_hash['id'], name: force_hash['name']).first_or_create
    end
  end

  desc "import categories"
  task :crime_categories => :environment do
  end
end
