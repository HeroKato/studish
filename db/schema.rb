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

ActiveRecord::Schema.define(version: 20160812082715) do

  create_table "coaches", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "full_name",                         null: false
    t.string   "email",                             null: false
    t.date     "birthday",                          null: false
    t.string   "university",                        null: false
    t.string   "major",                             null: false
    t.string   "school_year",                       null: false
    t.string   "self_introduction",                 null: false
    t.boolean  "administrator",     default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest",                   null: false
    t.string   "remember_digest"
    t.string   "picture"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "skype"
    t.string   "phone"
  end

  add_index "coaches", ["email"], name: "index_coaches_on_email", unique: true

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

end
