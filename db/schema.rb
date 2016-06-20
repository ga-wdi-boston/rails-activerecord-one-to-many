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

ActiveRecord::Schema.define(version: 20160620205851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "title"
    t.string   "artist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.integer  "population"
    t.string   "name"
    t.string   "country"
    t.string   "region"
    t.decimal  "longitude",  precision: 5
    t.decimal  "latitude",   precision: 6
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "surname"
    t.string   "given_name"
    t.string   "gender"
    t.integer  "height"
    t.integer  "weight"
    t.date     "born_on"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "home_town_id"
  end

  add_index "people", ["home_town_id"], name: "index_people_on_home_town_id", using: :btree

  create_table "pets", force: :cascade do |t|
    t.string   "born_on"
    t.string   "kind"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "person_id"
  end

  add_index "pets", ["person_id"], name: "index_pets_on_person_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "title"
    t.integer  "length"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "album_id"
  end

  add_index "songs", ["album_id"], name: "index_songs_on_album_id", using: :btree

  add_foreign_key "people", "cities", column: "home_town_id"
  add_foreign_key "pets", "people"
  add_foreign_key "songs", "albums"
end
