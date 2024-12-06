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

ActiveRecord::Schema[8.0].define(version: 2024_11_27_073202) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "team_member_histories", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "team_role_id", null: false
    t.integer "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_role_id", "team_id", "member_id"], name: "index_team_member_histories_on_role_and_team", unique: true
  end

  create_table "team_members", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "team_id", null: false
    t.integer "team_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "workspace_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "created_by_id", null: false
    t.integer "workspace_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address"
    t.string "password_digest"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "workspace_member_histories", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "workspace_id", null: false
    t.integer "workspace_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id", "workspace_role_id", "member_id"], name: "index_workspace_member_histories", unique: true
  end

  create_table "workspace_members", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.integer "member_id", null: false
    t.bigint "workspace_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id"], name: "index_workspace_members_on_workspace_id"
    t.index ["workspace_role_id"], name: "index_workspace_members_on_workspace_role_id"
  end

  create_table "workspace_roles", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "team_member_histories", "team_roles"
  add_foreign_key "team_member_histories", "teams"
  add_foreign_key "team_member_histories", "users", column: "member_id"
  add_foreign_key "team_members", "team_roles"
  add_foreign_key "team_members", "teams"
  add_foreign_key "team_members", "users", column: "member_id"
  add_foreign_key "team_roles", "workspaces"
  add_foreign_key "teams", "users", column: "created_by_id"
  add_foreign_key "teams", "workspaces"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "workspace_members", "users", column: "member_id"
  add_foreign_key "workspace_members", "workspace_roles"
  add_foreign_key "workspace_members", "workspaces"
  add_foreign_key "workspaces", "users", column: "created_by_id"
end
