# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150206044644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crimes", force: :cascade do |t|
    t.string "crime_id"
    t.string "month"
    t.string "reported_by"
    t.float  "lat"
    t.float  "lon"
    t.string "location"
    t.string "lsoa_code"
    t.string "lsoa_name"
    t.string "crime_type"
    t.string "falls_within"
    t.string "last_outcome_category"
    t.text   "context"
  end

  add_index "crimes", ["crime_type"], name: "index_crimes_on_crime_type", using: :btree
  add_index "crimes", ["month"], name: "index_crimes_on_month", using: :btree
  add_index "crimes", ["reported_by"], name: "index_crimes_on_reported_by", using: :btree

end
