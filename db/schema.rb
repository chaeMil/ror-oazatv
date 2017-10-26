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

ActiveRecord::Schema.define(version: 20171026144952) do

  create_table "archive_files", force: :cascade do |t|
    t.string "filename"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "archive_item_id"
    t.index ["archive_item_id"], name: "index_archive_files_on_archive_item_id"
  end

  create_table "archive_items", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "published"
    t.string "hash_id"
    t.date "date"
    t.text "tags"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
