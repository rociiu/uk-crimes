class CreateCrimes < ActiveRecord::Migration
  def change
    create_table :crimes do |t|
      t.string :crime_id
      t.string :month
      t.string :reported_by
      t.float :lat
      t.float :lon
      t.string :location
      t.string :lsoa_code
      t.string :lsoa_name
      t.string :crime_type
      t.string :falls_within
      t.string :last_outcome_category

      t.timestamps null: false
    end
  end
end
