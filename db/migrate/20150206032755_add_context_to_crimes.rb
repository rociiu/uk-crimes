class AddContextToCrimes < ActiveRecord::Migration
  def change
    add_column :crimes, :context, :text
  end
end
