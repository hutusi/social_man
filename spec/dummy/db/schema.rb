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

ActiveRecord::Schema.define(version: 2018_09_09_063634) do

  create_table "actions", force: :cascade do |t|
    t.string "action_subject_type"
    t.integer "action_subject_id"
    t.string "action_type"
    t.string "action_options"
    t.string "action_object_type"
    t.integer "action_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_object_type", "action_object_id"], name: "index_actions_on_action_object_type_and_action_object_id"
    t.index ["action_subject_type", "action_subject_id"], name: "index_actions_on_action_subject_type_and_action_subject_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
  end

  create_table "comments", force: :cascade do |t|
    t.string "body"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

end
