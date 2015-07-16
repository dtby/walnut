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

ActiveRecord::Schema.define(version: 20150716113056) do

  create_table "attachments", force: :cascade do |t|
    t.string   "content",              limit: 255
    t.string   "content_file_name",    limit: 255
    t.string   "content_content_type", limit: 255
    t.integer  "content_file_size",    limit: 4
    t.integer  "attachmentable_id",    limit: 4
    t.string   "attachmentable_type",  limit: 255
    t.string   "file_url",             limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "colleges", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "description",   limit: 65535
    t.string   "address",       limit: 255
    t.string   "web_address",   limit: 255
    t.string   "contact_phone", limit: 255
    t.string   "contact",       limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "logo_url",      limit: 255
  end

  create_table "courses", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "view_count",  limit: 4,     default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "degrees", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "sort_no",    limit: 4,   default: 1000
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.integer  "imageable_id",        limit: 4
    t.string   "imageable_type",      limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "interviews", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.string   "content",        limit: 255
    t.integer  "iv_category_id", limit: 4
    t.integer  "browse_count",   limit: 4,   default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "public_time",    limit: 255
    t.string   "image_url",      limit: 255
    t.integer  "view_count",     limit: 4
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
    t.string   "industry",         limit: 255
    t.integer  "number",           limit: 4
    t.integer  "view_count",       limit: 4
  end

  create_table "sms", force: :cascade do |t|
    t.string   "mobile",     limit: 255,              null: false
    t.string   "code",       limit: 255, default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "sms", ["mobile"], name: "index_sms_on_mobile", unique: true, using: :btree

  create_table "sub_courses", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "teacher_courses", force: :cascade do |t|
    t.integer  "teacher_id", limit: 4
    t.integer  "course_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "teacher_courses", ["course_id"], name: "index_teacher_courses_on_course_id", using: :btree
  add_index "teacher_courses", ["teacher_id"], name: "index_teacher_courses_on_teacher_id", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "deleted_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

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

  add_foreign_key "teacher_courses", "courses"
  add_foreign_key "teacher_courses", "teachers"
end
