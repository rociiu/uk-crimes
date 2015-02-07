class AddLatAndLonToForces < ActiveRecord::Migration
  def change
    add_column :forces, :lat, :float
    add_column :forces, :lon, :float
  end
end
