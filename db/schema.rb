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

ActiveRecord::Schema.define(version: 20140715185659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name",               default: "", null: false
    t.string   "path"
    t.string   "type"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "post_title_regex"
    t.string   "post_title_matches"
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id", using: :btree

  create_table "cities", force: true do |t|
    t.string   "name",       default: "", null: false
    t.string   "url",        default: "", null: false
    t.integer  "region_id"
    t.integer  "city_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abbrev"
  end

  add_index "cities", ["city_id"], name: "index_cities_on_city_id", using: :btree
  add_index "cities", ["region_id"], name: "index_cities_on_region_id", using: :btree

  create_table "feed_aggregators", force: true do |t|
    t.string   "name"
    t.text     "last_xml"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", force: true do |t|
    t.string   "url",                                        default: "", null: false
    t.decimal  "range_min",         precision: 10, scale: 2
    t.decimal  "range_max",         precision: 10, scale: 2
    t.string   "search_string"
    t.string   "last_url"
    t.string   "last_matching_url"
    t.integer  "category_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["category_id"], name: "index_feeds_on_category_id", using: :btree
  add_index "feeds", ["city_id"], name: "index_feeds_on_city_id", using: :btree

  create_table "feeds_feed_aggregators", force: true do |t|
    t.integer "feed_id"
    t.integer "feed_aggregator_id"
  end

  add_index "feeds_feed_aggregators", ["feed_aggregator_id"], name: "index_feeds_feed_aggregators_on_feed_aggregator_id", using: :btree
  add_index "feeds_feed_aggregators", ["feed_id"], name: "index_feeds_feed_aggregators_on_feed_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "url",        default: "", null: false
    t.string   "title",      default: "", null: false
    t.text     "body",       default: "", null: false
    t.integer  "feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["feed_id"], name: "index_posts_on_feed_id", using: :btree

  create_table "regions", force: true do |t|
    t.string   "name",       default: "", null: false
    t.integer  "region_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["region_id"], name: "index_regions_on_region_id", using: :btree

  create_table "search_booleans", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_fields", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "field_id"
    t.string   "field_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "search_fields", ["category_id"], name: "index_search_fields_on_category_id", using: :btree
  add_index "search_fields", ["field_id", "field_type"], name: "index_search_fields_on_field_id_and_field_type", using: :btree

  create_table "search_options", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.integer  "search_select_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "search_options", ["search_select_id"], name: "index_search_options_on_search_select_id", using: :btree

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

end
