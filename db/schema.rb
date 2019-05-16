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

ActiveRecord::Schema.define(version: 2019_05_16_043329) do

  create_table "friend_relations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "friend_id"], name: "index_friend_relations_on_user_id_and_friend_id", unique: true
  end

  create_table "friend_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "request_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "request_user_id"], name: "index_friend_requests_on_user_id_and_request_user_id", unique: true
    t.index ["user_id"], name: "index_friend_requests_on_user_id"
  end

  create_table "talk_rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "group_talk", default: false, null: false
    t.index ["updated_at"], name: "index_talk_rooms_on_updated_at"
  end

  create_table "talks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "talk_room_id"
    t.index ["user_id", "created_at"], name: "index_talks_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_talks_on_user_id"
  end

  create_table "user_talkroom_relations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "talk_room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["talk_room_id"], name: "index_user_talkroom_relations_on_talk_room_id"
    t.index ["user_id", "talk_room_id"], name: "index_user_talkroom_relations_on_user_id_and_talk_room_id"
    t.index ["user_id"], name: "index_user_talkroom_relations_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "friend_requests", "users"
  add_foreign_key "talks", "users"
  add_foreign_key "user_talkroom_relations", "talk_rooms"
  add_foreign_key "user_talkroom_relations", "users"
end
