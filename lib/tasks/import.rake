require 'csv'

namespace :import do
  desc "import crimes from csv"
  task :crimes => :environment do
    csv_path = ENV['CSV']
    if File.exists?(csv_path)
      puts "Start importing crimes."
      count = 0
      CSV.foreach(csv_path, headers: true) do |row|
        next if row['Crime ID'].blank?
        count += 1
        print '.' if count % 100 == 0
        crime = Crime.find_or_initialize_by(crime_id: row['Crime ID'])
        crime.update(
          month: row['Month'],
          reported_by: row['Reported by'],
          lat: row['Latitude'],
          lon: row['Longitude'],
          falls_within: row['Falls within'],
          location: row['Location'],
          lsoa_code: row['LSOA code'],
          lsoa_name: row['LSOA name'],
          crime_type: row['Crime type'],
          last_outcome_category: row['Last outcome category']
        )
      end
      puts
      puts "Finished importing crimes."
    end
  end
end
