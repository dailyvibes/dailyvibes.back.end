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

ActiveRecord::Schema.define(version: 2018_07_11_010024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "lists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.datetime "duedate_at"
    t.datetime "archived_at"
    t.datetime "completed_at"
    t.text "title_description"
    t.string "emoji"
    t.string "color"
    t.boolean "favourite", default: false
    t.boolean "visible", default: false
    t.boolean "public", default: false
    t.boolean "dv_default", default: false
    t.uuid "user_id"
    t.boolean "synced", default: false
    t.string "synced_id"
    t.datetime "sync_began_at"
    t.datetime "sync_finished_at"
    t.string "synced_device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "notes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "completed_at"
    t.datetime "archived_at"
    t.boolean "public", default: false
    t.boolean "favourite", default: false
    t.uuid "todotask_item_id"
    t.boolean "synced", default: false
    t.string "synced_id"
    t.datetime "sync_began_at"
    t.datetime "sync_finished_at"
    t.string "synced_device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todotask_item_id"], name: "index_notes_on_todotask_item_id"
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "label"
    t.boolean "archived", default: false
    t.boolean "public", default: false
    t.string "colour_representation"
    t.string "emoji"
    t.uuid "todotask_item_id"
    t.boolean "synced", default: false
    t.string "synced_id"
    t.datetime "sync_began_at"
    t.datetime "sync_finished_at"
    t.string "synced_device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todotask_item_id"], name: "index_tags_on_todotask_item_id"
  end

  create_table "todotask_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.datetime "duedate_at"
    t.datetime "archived_at"
    t.datetime "completed_at"
    t.boolean "completed", default: false
    t.boolean "archived", default: false
    t.boolean "new", default: true
    t.boolean "public", default: false
    t.boolean "favourite", default: false
    t.boolean "remindable", default: false
    t.boolean "synced", default: false
    t.string "synced_id"
    t.datetime "sync_began_at"
    t.datetime "sync_finished_at"
    t.string "synced_device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "list_id", null: false
    t.index ["list_id"], name: "index_todotask_items_on_list_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false
    t.string "role", default: "['guest']"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
