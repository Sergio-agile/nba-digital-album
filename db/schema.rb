# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_12_134528) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_cards", force: :cascade do |t|
    t.integer "counter", default: 0
    t.bigint "album_id", null: false
    t.bigint "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_album_cards_on_album_id"
    t.index ["card_id"], name: "index_album_cards_on_card_id"
  end

  create_table "albums", force: :cascade do |t|
    t.string "season"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "team"
    t.string "position"
    t.date "birthdate"
    t.string "draft"
    t.float "height"
    t.float "weight"
    t.float "points"
    t.float "rebounds"
    t.float "assists"
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "season"
    t.string "image"
  end

  create_table "quiz_answers", force: :cascade do |t|
    t.string "text"
    t.boolean "correct"
    t.bigint "quiz_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_answers_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "question"
    t.string "true_answer"
    t.string "false_answer_one"
    t.string "false_answer_two"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "album_cards", "albums"
  add_foreign_key "album_cards", "cards"
  add_foreign_key "albums", "users"
  add_foreign_key "quiz_answers", "quizzes"
end
