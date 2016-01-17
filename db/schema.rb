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

ActiveRecord::Schema.define(version: 20151120183503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.string   "name",                        null: false
    t.datetime "last_message_at"
    t.integer  "messages_count",  default: 0, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "channels", ["created_at"], name: "index_channels_on_created_at", using: :btree
  add_index "channels", ["last_message_at"], name: "index_channels_on_last_message_at", using: :btree
  add_index "channels", ["name"], name: "index_channels_on_name", using: :btree
  add_index "channels", ["name"], name: "name_uniqueness", unique: true, using: :btree
  add_index "channels", ["updated_at"], name: "index_channels_on_updated_at", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "subtitle"
    t.integer  "channel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["channel_id"], name: "index_messages_on_channel_id", using: :btree
  add_index "messages", ["title"], name: "index_messages_on_title", using: :btree

  add_foreign_key "messages", "channels"
end
