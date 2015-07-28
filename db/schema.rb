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

ActiveRecord::Schema.define(version: 20150728123219) do

  create_table "announces", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "project_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "announces", ["project_id"], name: "index_announces_on_project_id", using: :btree
  add_index "announces", ["user_id"], name: "index_announces_on_user_id", using: :btree

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
    t.integer  "sub_course_id",        limit: 4
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

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.string   "title",            limit: 255
    t.text     "body",             limit: 65535
    t.string   "subject",          limit: 255
    t.integer  "user_id",          limit: 4,     null: false
    t.integer  "parent_id",        limit: 4
    t.integer  "lft",              limit: 4
    t.integer  "rgt",              limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

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
    t.string   "city",          limit: 255
    t.string   "industry",      limit: 255
    t.string   "nature",        limit: 255
    t.string   "scale",         limit: 255
  end

  create_table "courses", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "view_count",  limit: 4,     default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "teacher_id",  limit: 4
    t.integer  "college_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.text     "detail",      limit: 65535
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

  create_table "kindeditor_assets", force: :cascade do |t|
    t.string   "asset",      limit: 255
    t.integer  "file_size",  limit: 4
    t.string   "file_type",  limit: 255
    t.integer  "owner_id",   limit: 4
    t.string   "asset_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "project_id", limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "notifications", ["project_id"], name: "index_notifications_on_project_id", using: :btree

  create_table "project_courses", force: :cascade do |t|
    t.integer  "project_id", limit: 4
    t.integer  "course_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "project_courses", ["course_id"], name: "index_project_courses_on_course_id", using: :btree
  add_index "project_courses", ["project_id"], name: "index_project_courses_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.boolean  "is_public",               default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
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
    t.datetime "publish_time"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "industry",         limit: 255
    t.integer  "number",           limit: 4
    t.string   "nature",           limit: 255
    t.string   "department",       limit: 255
    t.string   "need_person",      limit: 255
    t.datetime "stop_time"
    t.string   "must_school",      limit: 255
    t.string   "must_specialty1",  limit: 255
    t.string   "must_specialty2",  limit: 255
    t.string   "age",              limit: 255
    t.string   "experience",       limit: 255
    t.string   "it_tec",           limit: 255
    t.text     "responsibility",   limit: 65535
    t.text     "demand",           limit: 65535
    t.integer  "recruit_type",     limit: 4,     default: 0
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
    t.integer  "course_id",   limit: 4
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "task_categories", force: :cascade do |t|
    t.integer  "project_id",  limit: 4
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "unfinished",  limit: 4,   default: 0
    t.integer  "total",       limit: 4,   default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "task_categories", ["project_id"], name: "index_task_categories_on_project_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "project_id",       limit: 4
    t.integer  "task_category_id", limit: 4
    t.integer  "No",               limit: 4
    t.string   "name",             limit: 255
    t.string   "description",      limit: 255
    t.date     "end_time"
    t.integer  "level",            limit: 4
    t.integer  "state",            limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["task_category_id"], name: "index_tasks_on_task_category_id", using: :btree

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

  create_table "user_notifications", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "notification_id", limit: 4
    t.integer  "state",           limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "user_notifications", ["notification_id"], name: "index_user_notifications_on_notification_id", using: :btree
  add_index "user_notifications", ["user_id"], name: "index_user_notifications_on_user_id", using: :btree

  create_table "user_projects", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "project_id", limit: 4
    t.integer  "role",       limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "invite"
  end

  add_index "user_projects", ["project_id"], name: "index_user_projects_on_project_id", using: :btree
  add_index "user_projects", ["user_id"], name: "index_user_projects_on_user_id", using: :btree

  create_table "user_recruitments", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "recruitment_id", limit: 4
    t.integer  "state",          limit: 4, default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.time     "deliver_time"
  end

  add_index "user_recruitments", ["recruitment_id"], name: "index_user_recruitments_on_recruitment_id", using: :btree
  add_index "user_recruitments", ["user_id"], name: "index_user_recruitments_on_user_id", using: :btree

  create_table "user_tasks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "task_id",    limit: 4
    t.integer  "role",       limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_tasks", ["task_id"], name: "index_user_tasks_on_task_id", using: :btree
  add_index "user_tasks", ["user_id"], name: "index_user_tasks_on_user_id", using: :btree

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
    t.string   "name",                   limit: 255
    t.string   "major",                  limit: 255
    t.string   "department",             limit: 255
    t.string   "gender",                 limit: 255
    t.string   "signature",              limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["mobile"], name: "index_users_on_mobile", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id",   limit: 4
    t.string   "votable_type", limit: 255
    t.integer  "voter_id",     limit: 4
    t.string   "voter_type",   limit: 255
    t.boolean  "vote_flag"
    t.string   "vote_scope",   limit: 255
    t.integer  "vote_weight",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "teacher_courses", "courses"
  add_foreign_key "teacher_courses", "teachers"
end
