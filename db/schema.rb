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

ActiveRecord::Schema.define(version: 20160215161825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offer_versions", force: :cascade do |t|
    t.text     "html_content"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "offer_id",                 null: false
    t.integer  "scan_id",      default: 1, null: false
  end

  create_table "offers", force: :cascade do |t|
    t.boolean  "hidden",        default: false, null: false
    t.integer  "price"
    t.string   "hood"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "offer_hash",                    null: false
    t.integer  "first_scan_id",                 null: false
  end

  add_index "offers", ["offer_hash"], name: "index_offers_on_offer_hash", unique: true, using: :btree

  create_table "offers_tags", force: :cascade do |t|
    t.integer "offer_id"
    t.integer "tag_id"
  end

  create_table "scan_urls", force: :cascade do |t|
    t.string   "url",                     null: false
    t.string   "url_suffix", default: "", null: false
    t.string   "name",                    null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "scans", force: :cascade do |t|
    t.integer  "pages",                   null: false
    t.integer  "all_offers",  default: 0, null: false
    t.integer  "new_offers",  default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "scan_url_id",             null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "label",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["label"], name: "index_tags_on_label", unique: true, using: :btree

end
