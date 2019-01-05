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

ActiveRecord::Schema.define(version: 20181228103133) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "archive_files", force: :cascade do |t|
    t.string "file"
    t.integer "file_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "archive_item_id"
    t.boolean "used_as_conversion_source"
    t.float "sync"
    t.integer "language_id"
    t.index ["archive_item_id"], name: "index_archive_files_on_archive_item_id"
    t.index ["language_id"], name: "index_archive_files_on_language_id"
  end

  create_table "archive_item_translations", force: :cascade do |t|
    t.integer "archive_item_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.index ["archive_item_id"], name: "index_archive_item_translations_on_archive_item_id"
    t.index ["locale"], name: "index_archive_item_translations_on_locale"
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
    t.integer "views"
  end

  create_table "archive_items_categories", id: false, force: :cascade do |t|
    t.integer "archive_item_id", null: false
    t.integer "category_id", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_translations", force: :cascade do |t|
    t.integer "category_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["category_id"], name: "index_category_translations_on_category_id"
    t.index ["locale"], name: "index_category_translations_on_locale"
  end

  create_table "languages", force: :cascade do |t|
    t.text "title"
    t.text "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photo_album_translations", force: :cascade do |t|
    t.integer "photo_album_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.index ["locale"], name: "index_photo_album_translations_on_locale"
    t.index ["photo_album_id"], name: "index_photo_album_translations_on_photo_album_id"
  end

  create_table "preacher_translations", force: :cascade do |t|
    t.integer "preacher_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["locale"], name: "index_preacher_translations_on_locale"
    t.index ["preacher_id"], name: "index_preacher_translations_on_preacher_id"
  end

  create_table "preachers", force: :cascade do |t|
    t.text "title"
    t.text "tags"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "video_convert_profiles", force: :cascade do |t|
    t.text "title"
    t.text "video_codec"
    t.float "frame_rate"
    t.text "resolution"
    t.integer "video_bitrate"
    t.text "audio_codec"
    t.integer "audio_bitrate"
    t.integer "audio_sample_rate"
    t.integer "audio_channels"
    t.integer "threads"
    t.text "custom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "extension"
  end

  create_table "video_convert_progresses", force: :cascade do |t|
    t.float "progress"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "finished_at"
    t.integer "archive_file_id"
    t.datetime "started_at"
    t.text "error"
    t.integer "original_archive_file_id"
    t.index ["original_archive_file_id"], name: "index_video_convert_progresses_on_original_archive_file_id"
  end

  create_table "video_views", force: :cascade do |t|
    t.string "video_hash_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "video_watches", force: :cascade do |t|
    t.string "video_hash_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
