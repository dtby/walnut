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

ActiveRecord::Schema.define(version: 20150715060716) do

  create_table "companies", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "description",   limit: 65535
    t.string   "address",       limit: 255
    t.string   "web_address",   limit: 255
    t.string   "contact_phone", limit: 255
    t.string   "contact",       limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "degrees", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "sort_no",    limit: 4,   default: 1000
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "interviews", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.string   "content",        limit: 255
    t.integer  "iv_category_id", limit: 4
    t.integer  "browse_count",   limit: 4,   default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "interviews", ["iv_category_id"], name: "index_interviews_on_iv_category_id", using: :btree

  create_table "iv_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "sort_no",    limit: 4,   default: 1000
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "recruitments", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "gender",           limit: 255
    t.string   "certificate",      limit: 255
    t.integer  "degree_id",        limit: 4
    t.integer  "company_id",       limit: 4
    t.string   "category",         limit: 255
    t.string   "city",             limit: 255
    t.string   "remuneration",     limit: 255
    t.string   "foreign_language", limit: 255
    t.string   "others",           limit: 255
    t.text     "description",      limit: 65535
    t.string   "hr_email",         limit: 255
    t.integer  "browse_count",     limit: 4,     default: 0
    t.string   "publish_time",     limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "sms", force: :cascade do |t|
    t.string   "mobile",     limit: 255,              null: false
    t.string   "code",       limit: 255, default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "sms", ["mobile"], name: "index_sms_on_mobile", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "mobile",                 limit: 255, default: "", null: false
    t.string   "nickname",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["mobile"], name: "index_users_on_mobile", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "interviews", "iv_categories"
end
