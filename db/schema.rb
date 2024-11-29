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

ActiveRecord::Schema[8.0].define(version: 2024_11_28_115100) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "member_histories", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "workspace_id", null: false
    t.integer "workspace_role_id", null: false
    t.integer "team_id"
    t.integer "team_role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id", "workspace_id", "team_id", "team_role_id", "workspace_role_id"], name: "index_for_unique", unique: true
    t.index ["member_id", "workspace_id", "workspace_role_id"], name: "index_member_histories_on_member_workspace_role", unique: true, where: "((team_id IS NULL) AND (team_role_id IS NULL))"
  end

  create_table "team_members", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "team_id", null: false
    t.integer "team_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id", "member_id", "team_role_id"], name: "index_team_members_on_team_member_role", unique: true
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

  create_table "workspace_members", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.integer "member_id", null: false
    t.bigint "workspace_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id", "member_id", "workspace_role_id"], name: "index_workspace_members_on_workspace_member_role", unique: true
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "member_histories", "team_roles"
  add_foreign_key "member_histories", "teams"
  add_foreign_key "member_histories", "users", column: "member_id"
  add_foreign_key "member_histories", "workspace_roles"
  add_foreign_key "member_histories", "workspaces"
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
