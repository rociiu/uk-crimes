class AddIndexes < ActiveRecord::Migration
  def change
    add_index :crimes, :month
    add_index :crimes, :reported_by
    add_index :crimes, :crime_type
  end
end
