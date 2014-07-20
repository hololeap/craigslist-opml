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

ActiveRecord::Schema.define(version: 20140719222118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "path"
    t.string   "type"
    t.string   "post_title_regex"
    t.string   "post_title_matches"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_search_fields", force: true do |t|
    t.integer "category_id"
    t.integer "search_field_id"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "abbrev"
    t.integer  "region_id"
    t.integer  "city_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_aggregators", force: true do |t|
    t.string   "name"
    t.text     "last_xml"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", force: true do |t|
    t.string   "url"
    t.string   "last_url"
    t.string   "last_matching_url"
    t.integer  "category_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "url"
    t.string   "title"
    t.text     "body"
    t.integer  "feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_booleans", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_fields", force: true do |t|
    t.string   "name"
    t.string   "search_attribute"
    t.integer  "field_id"
    t.string   "field_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_options", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.integer  "search_select_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_ranges", force: true do |t|
    t.string   "min_name"
    t.string   "max_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_selects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_texts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_values", force: true do |t|
    t.string   "value"
    t.integer  "search_field_id"
    t.integer  "feed_id"
    t.integer  "feed_aggregator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
