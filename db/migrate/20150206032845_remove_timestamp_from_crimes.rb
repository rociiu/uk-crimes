class RemoveTimestampFromCrimes < ActiveRecord::Migration
  def change
    remove_timestamps :crimes
  end
end
