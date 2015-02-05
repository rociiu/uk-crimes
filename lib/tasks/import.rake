require 'csv'

namespace :import do

  def import_from_csv_file(csv_path)
    if File.exists?(csv_path)
      puts "Start importing crimes from #{csv_path}."
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
end
