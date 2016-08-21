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

ActiveRecord::Schema.define(version: 20160818164101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.text     "original_text"
    t.text     "translated_text"
    t.date     "review_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "deck_id"
    t.integer  "level",                           default: 0
    t.integer  "fail_counter",                    default: 0
  end

  add_index "cards", ["deck_id"], name: "index_cards_on_deck_id", using: :btree
  add_index "cards", ["user_id"], name: "index_cards_on_user_id", using: :btree

  create_table "decks", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "decks", ["user_id"], name: "index_decks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.text     "email"
    t.text     "password"
    t.text     "crypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt",             limit: 255
    t.integer  "current_deck_id"
    t.string   "locale",                       default: "en"
  end

end
