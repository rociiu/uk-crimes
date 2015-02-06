class CreateCrimeCategories < ActiveRecord::Migration
  def change
    create_table :crime_categories do |t|
      t.string :category_id
      t.string :name

      t.timestamps null: false
    end
  end
end
