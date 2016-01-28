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

ActiveRecord::Schema.define(version: 20160127145051) do

  create_table "draftables", force: true do |t|
    t.string   "name"
    t.integer  "rank"
    t.integer  "draft_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "draftables", ["draft_id"], name: "index_draftables_on_draft_id"

  create_table "drafts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drafts_players", force: true do |t|
    t.integer "player_id"
    t.integer "draft_id"
  end

  add_index "drafts_players", ["draft_id"], name: "index_drafts_players_on_draft_id"
  add_index "drafts_players", ["player_id"], name: "index_drafts_players_on_player_id"

  create_table "picks", force: true do |t|
    t.integer  "draft_id"
    t.integer  "player_id"
    t.integer  "draftable_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "picks", ["draft_id"], name: "index_picks_on_draft_id"
  add_index "picks", ["player_id"], name: "index_picks_on_player_id"

  create_table "players", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["email"], name: "index_players_on_email"

end
