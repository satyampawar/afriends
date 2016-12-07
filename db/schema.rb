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

ActiveRecord::Schema.define(version: 20161206143318) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "user_id"
    t.string   "album_name"
    t.string   "status"
    t.boolean  "hide"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "locked",     default: "No"
    t.string   "pin"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "friendlists", force: :cascade do |t|
    t.string   "user_id"
    t.string   "friend_id"
    t.string   "blockstatus"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "friendlogs", force: :cascade do |t|
    t.string   "user_id"
    t.string   "friend_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.string   "user_id"
    t.string   "integer"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "page_institutes", force: :cascade do |t|
    t.decimal  "lats"
    t.decimal  "long"
    t.text     "address"
    t.integer  "page_id"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "page_movies", force: :cascade do |t|
    t.string   "url"
    t.integer  "imdb_id"
    t.integer  "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "page_type"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.string   "mobile_number"
    t.string   "pin"
    t.boolean  "verified"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "photoposts", force: :cascade do |t|
    t.string   "post_id"
    t.string   "photopst_file_name"
    t.string   "photopst_content_type"
    t.integer  "photopst_file_size"
    t.datetime "photopst_updated_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "user_id"
    t.string   "album_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.boolean  "hide"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "user_id"
    t.string   "post_name"
    t.string   "post_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "secured_keys", force: :cascade do |t|
    t.text     "salt"
    t.text     "key"
    t.integer  "document_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "user_verify",            default: false
    t.string   "confirm_token"
    t.string   "worked_at"
    t.string   "collage"
    t.string   "school"
    t.string   "llves"
    t.string   "hometown"
    t.string   "nickname"
    t.string   "img_url"
    t.string   "coverpic_file_name"
    t.string   "coverpic_content_type"
    t.integer  "coverpic_file_size"
    t.datetime "coverpic_updated_at"
    t.decimal  "coverpos"
    t.string   "provider"
    t.string   "uid"
    t.datetime "last_seen"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
