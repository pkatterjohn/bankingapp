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

ActiveRecord::Schema.define(version: 20190709161734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.string   "name",         null: false
    t.string   "account_type", null: false
    t.float    "amount",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "external_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name",        null: false
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string   "type_name",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "transaction_type", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "acct_from"
    t.integer  "acct_to"
    t.float    "transfer_amount",  null: false
    t.string   "description"
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "login",           null: false
    t.integer  "admin",           null: false
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "password_digest"
    t.string   "remember_digest"
  end

  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree

  add_foreign_key "accounts", "users"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "organizations"
end
