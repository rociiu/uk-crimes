class CreateForces < ActiveRecord::Migration
  def change
    create_table :forces do |t|
      t.string :force_id
      t.string :name

      t.timestamps null: false
    end
  end
end
