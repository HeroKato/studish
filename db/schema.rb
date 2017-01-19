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

ActiveRecord::Schema.define(version: 20170115094527) do

  create_table "coach_certifications", force: :cascade do |t|
    t.integer  "coach_id",   null: false
    t.string   "eiken"
    t.integer  "toeic"
    t.integer  "toefl"
    t.float    "ielts"
    t.string   "kanken"
    t.string   "suuken"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "coach_certifications", ["coach_id"], name: "index_coach_certifications_on_coach_id"

  create_table "coaches", force: :cascade do |t|
    t.string   "name",              default: "no_name"
    t.string   "account_name",                          null: false
    t.string   "email",                                 null: false
    t.string   "avatar"
    t.date     "birthday"
    t.string   "university"
    t.string   "major"
    t.string   "school_year"
    t.text     "self_introduction"
    t.string   "skype"
    t.string   "phone"
    t.boolean  "administrator",     default: false,     null: false
    t.string   "password_digest",                       null: false
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false,     null: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "deleted",           default: false,     null: false
    t.datetime "deleted_at"
    t.boolean  "suspended",         default: false,     null: false
    t.datetime "susupended_at"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "coaches", ["account_name", "created_at"], name: "index_coaches_on_account_name_and_created_at"
  add_index "coaches", ["account_name"], name: "index_coaches_on_account_name"
  add_index "coaches", ["major"], name: "index_coaches_on_major"
  add_index "coaches", ["name", "created_at"], name: "index_coaches_on_name_and_created_at"
  add_index "coaches", ["name"], name: "index_coaches_on_name"
  add_index "coaches", ["school_year"], name: "index_coaches_on_school_year"
  add_index "coaches", ["university"], name: "index_coaches_on_university"

  create_table "coaching_reports", force: :cascade do |t|
    t.integer  "coach_id",                     null: false
    t.string   "title",                        null: false
    t.text     "body"
    t.string   "status",     default: "draft", null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "coaching_reports", ["coach_id"], name: "index_coaching_reports_on_coach_id"

  create_table "coaching_subjects", force: :cascade do |t|
    t.integer  "coach_id",             null: false
    t.string   "jr_english"
    t.string   "jr_japanese"
    t.string   "jr_math"
    t.string   "jr_science"
    t.string   "jr_social"
    t.string   "high_english"
    t.string   "modern_japanese"
    t.string   "classical_japanese"
    t.string   "classical_chinese"
    t.string   "world_history_a"
    t.string   "world_history_b"
    t.string   "japanese_history_a"
    t.string   "japanese_history_b"
    t.string   "geography_a"
    t.string   "geography_b"
    t.string   "contemporary_society"
    t.string   "ethics"
    t.string   "politics_economics"
    t.string   "math_1a"
    t.string   "math_2b"
    t.string   "math_3"
    t.string   "basic_physics"
    t.string   "physics"
    t.string   "basic_chemistry"
    t.string   "chemistry"
    t.string   "basic_biology"
    t.string   "biology"
    t.string   "basic_earth_science"
    t.string   "earth_science"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "coaching_subjects", ["coach_id"], name: "index_coaching_subjects_on_coach_id"

  create_table "comment_pictures", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "coach_id"
    t.integer  "post_comment_id"
    t.string   "pictures"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "comment_pictures", ["coach_id", "created_at"], name: "index_comment_pictures_on_coach_id_and_created_at"
  add_index "comment_pictures", ["post_comment_id", "created_at"], name: "index_comment_pictures_on_post_comment_id_and_created_at"
  add_index "comment_pictures", ["post_comment_id"], name: "index_comment_pictures_on_post_comment_id"
  add_index "comment_pictures", ["student_id", "created_at"], name: "index_comment_pictures_on_student_id_and_created_at"

  create_table "comments", force: :cascade do |t|
    t.integer  "coaching_report_id",                 null: false
    t.integer  "coach_id",                           null: false
    t.integer  "commented_coach_id"
    t.text     "body"
    t.boolean  "read_flag",          default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "comments", ["coach_id"], name: "index_comments_on_coach_id"
  add_index "comments", ["coaching_report_id"], name: "index_comments_on_coaching_report_id"

  create_table "favorites", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "coach_id"
    t.integer  "favorited_student_id"
    t.integer  "favorited_coach_id"
    t.integer  "post_id"
    t.integer  "post_comment_id"
    t.integer  "coaching_report_id"
    t.boolean  "check_flag",           default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "favorites", ["check_flag"], name: "index_favorites_on_check_flag"
  add_index "favorites", ["coach_id"], name: "index_favorites_on_coach_id"
  add_index "favorites", ["coaching_report_id"], name: "index_favorites_on_coaching_report_id"
  add_index "favorites", ["created_at"], name: "index_favorites_on_created_at"
  add_index "favorites", ["favorited_coach_id"], name: "index_favorites_on_favorited_coach_id"
  add_index "favorites", ["favorited_student_id"], name: "index_favorites_on_favorited_student_id"
  add_index "favorites", ["post_comment_id"], name: "index_favorites_on_post_comment_id"
  add_index "favorites", ["post_id"], name: "index_favorites_on_post_id"
  add_index "favorites", ["student_id"], name: "index_favorites_on_student_id"

  create_table "post_comments", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "coach_id"
    t.integer  "post_id"
    t.integer  "commented_student_id"
    t.integer  "commented_coach_id"
    t.text     "caption"
    t.string   "status",                    default: "answer"
    t.boolean  "check_flag",                default: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "commented_post_comment_id"
    t.integer  "root_post_comment_id"
  end

  add_index "post_comments", ["coach_id", "created_at"], name: "index_post_comments_on_coach_id_and_created_at"
  add_index "post_comments", ["post_id", "created_at"], name: "index_post_comments_on_post_id_and_created_at"
  add_index "post_comments", ["post_id"], name: "index_post_comments_on_post_id"
  add_index "post_comments", ["student_id", "created_at"], name: "index_post_comments_on_student_id_and_created_at"

  create_table "post_pictures", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "post_id"
    t.string   "pictures"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_pictures", ["post_id", "created_at"], name: "index_post_pictures_on_post_id_and_created_at"
  add_index "post_pictures", ["student_id", "created_at"], name: "index_post_pictures_on_student_id_and_created_at"

  create_table "posts", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "coach_id"
    t.integer  "commented_student_id"
    t.integer  "commented_coach_id"
    t.text     "caption"
    t.string   "status",               default: "question", null: false
    t.string   "subject"
    t.string   "text_name"
    t.string   "chapter"
    t.string   "section"
    t.string   "page"
    t.string   "number"
    t.string   "pattern"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "posts", ["chapter", "created_at"], name: "index_posts_on_chapter_and_created_at"
  add_index "posts", ["coach_id", "created_at"], name: "index_posts_on_coach_id_and_created_at"
  add_index "posts", ["pattern", "created_at"], name: "index_posts_on_pattern_and_created_at"
  add_index "posts", ["section", "created_at"], name: "index_posts_on_section_and_created_at"
  add_index "posts", ["student_id", "created_at"], name: "index_posts_on_student_id_and_created_at"
  add_index "posts", ["subject", "created_at"], name: "index_posts_on_subject_and_created_at"
  add_index "posts", ["text_name", "created_at"], name: "index_posts_on_text_name_and_created_at"

  create_table "students", force: :cascade do |t|
    t.string   "name",              default: "no_name"
    t.string   "account_name",                          null: false
    t.string   "email",                                 null: false
    t.string   "avatar"
    t.text     "self_introduction"
    t.string   "password_digest",                       null: false
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false,     null: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "deleted",           default: false,     null: false
    t.datetime "deleted_at"
    t.boolean  "suspended",         default: false,     null: false
    t.datetime "suspended_at"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "students", ["account_name", "created_at"], name: "index_students_on_account_name_and_created_at"
  add_index "students", ["account_name"], name: "index_students_on_account_name"
  add_index "students", ["activated", "created_at"], name: "index_students_on_activated_and_created_at"
  add_index "students", ["activated"], name: "index_students_on_activated"
  add_index "students", ["deleted", "created_at"], name: "index_students_on_deleted_and_created_at"
  add_index "students", ["deleted"], name: "index_students_on_deleted"
  add_index "students", ["email"], name: "index_students_on_email"
  add_index "students", ["name", "created_at"], name: "index_students_on_name_and_created_at"
  add_index "students", ["name"], name: "index_students_on_name"
  add_index "students", ["suspended", "created_at"], name: "index_students_on_suspended_and_created_at"
  add_index "students", ["suspended"], name: "index_students_on_suspended"

end
