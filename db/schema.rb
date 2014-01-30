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

ActiveRecord::Schema.define(version: 20140130163350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: true do |t|
    t.text     "name"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["artist_id"], name: "index_albums_on_artist_id", using: :btree

  create_table "artists", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors_books", id: false, force: true do |t|
    t.integer "author_id", null: false
    t.integer "book_id",   null: false
  end

  add_index "authors_books", ["author_id", "book_id"], name: "index_authors_books_on_author_id_and_book_id", using: :btree
  add_index "authors_books", ["book_id", "author_id"], name: "index_authors_books_on_book_id_and_author_id", using: :btree

  create_table "books", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", force: true do |t|
    t.text    "name"
    t.integer "length"
    t.integer "album_id"
  end

  add_index "songs", ["album_id"], name: "index_songs_on_album_id", using: :btree

end
