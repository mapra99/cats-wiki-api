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

ActiveRecord::Schema.define(version: 2021_02_25_200622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "breed_search_results", force: :cascade do |t|
    t.bigint "breed_search_id"
    t.string "breed_id"
    t.index ["breed_search_id"], name: "index_breed_search_results_on_breed_search_id"
  end

  create_table "breed_searches", force: :cascade do |t|
    t.string "query_term", null: false
    t.boolean "succeed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "search_by"
  end

  create_table "user_clicks", force: :cascade do |t|
    t.string "path_name", null: false
    t.integer "clicks_amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "breed_search_results", "breed_searches"
end
