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

ActiveRecord::Schema.define(version: 20160714233354) do

  create_table "coaches", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "full_name",                         null: false
    t.string   "email",                             null: false
    t.date     "birthday",                          null: false
    t.string   "university",                        null: false
    t.string   "major",                             null: false
    t.string   "school_year",                       null: false
    t.string   "subject",                           null: false
    t.string   "self_introduction",                 null: false
    t.boolean  "administrator",     default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest",                   null: false
    t.string   "remember_digest"
    t.string   "picture"
  end

  add_index "coaches", ["email"], name: "index_coaches_on_email", unique: true

end
