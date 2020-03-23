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

ActiveRecord::Schema.define(version: 20200322234241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "index_news", force: :cascade do |t|
    t.string "title"
    t.text "bodyone"
    t.text "subtitle"
    t.text "bodytwho"
    t.string "subtitletwo"
    t.text "bodythree"
    t.text "imageone"
    t.text "imagetwo"
    t.text "imagethree"
    t.string "img_url_one"
    t.string "img_url_two"
    t.string "img_url_three"
    t.string "autor"
    t.string "note_1"
    t.string "note_2"
  end

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "imageNew"
    t.string "imageurl"
    t.string "img_url"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "description"
    t.string "mark"
    t.string "imgurl"
    t.string "available"
    t.text "image"
    t.string "category"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "name"
    t.string "subject"
    t.string "email"
    t.string "phone"
    t.string "mesagge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "is_subscriber"
  end

  create_table "works", force: :cascade do |t|
    t.string "title"
    t.string "category"
    t.text "description"
    t.text "first_image"
    t.string "first_header"
    t.text "first_description"
    t.text "second_image"
    t.string "second_header"
    t.text "second_description"
    t.text "third_image"
    t.string "third_header"
    t.text "third_description"
    t.text "fourth_image"
    t.string "fourth_header"
    t.text "fourth_description"
    t.text "fifth_image"
    t.string "fifth_header"
    t.text "fifth_description"
    t.text "sixth_image"
    t.string "sixth_header"
    t.text "sixth_description"
    t.string "img_url_one"
    t.string "img_url_two"
    t.string "img_url_three"
    t.string "img_url_fourth"
    t.string "img_url_fifth"
    t.string "img_url_sixth"
  end

end
