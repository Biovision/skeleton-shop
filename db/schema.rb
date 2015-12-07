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

ActiveRecord::Schema.define(version: 20151201223542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brand_categories", force: :cascade do |t|
    t.integer "brand_id",    null: false
    t.integer "category_id", null: false
  end

  add_index "brand_categories", ["brand_id"], name: "index_brand_categories_on_brand_id", using: :btree
  add_index "brand_categories", ["category_id"], name: "index_brand_categories_on_category_id", using: :btree

  create_table "brands", force: :cascade do |t|
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "items_count", limit: 2, default: 0, null: false
    t.string   "name",                              null: false
    t.string   "slug",                              null: false
    t.string   "image"
    t.text     "description"
  end

  add_index "brands", ["slug"], name: "index_brands_on_slug", using: :btree

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "priority",    limit: 2, default: 1,    null: false
    t.boolean  "visible",               default: true, null: false
    t.integer  "brand_count", limit: 2, default: 0,    null: false
    t.integer  "item_count",  limit: 2, default: 0,    null: false
    t.string   "name",                                 null: false
    t.string   "slug",                                 null: false
    t.string   "image"
    t.text     "description"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "item_categories", force: :cascade do |t|
    t.integer  "item_id",     null: false
    t.integer  "category_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "item_categories", ["category_id"], name: "index_item_categories_on_category_id", using: :btree
  add_index "item_categories", ["item_id"], name: "index_item_categories_on_item_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "brand_id"
    t.integer  "price"
    t.boolean  "visible",     default: true, null: false
    t.string   "name",                       null: false
    t.string   "slug",                       null: false
    t.string   "image"
    t.text     "description"
  end

  add_index "items", ["brand_id"], name: "index_items_on_brand_id", using: :btree
  add_index "items", ["slug"], name: "index_items_on_slug", unique: true, using: :btree

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "order_id",             null: false
    t.integer  "item_id",              null: false
    t.integer  "quantity",   limit: 2, null: false
    t.integer  "price",                null: false
  end

  add_index "order_items", ["item_id"], name: "index_order_items_on_item_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "number",                 null: false
    t.integer  "price",      default: 0, null: false
    t.integer  "item_count", default: 0, null: false
    t.integer  "state",      default: 0, null: false
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.text     "comment"
  end

  create_table "user_roles", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "user_id"
    t.integer  "role",       limit: 2, null: false
  end

  add_index "user_roles", ["user_id", "role"], name: "index_user_roles_on_user_id_and_role", unique: true, using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "login",           null: false
    t.string   "password_digest", null: false
    t.string   "email"
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree

  add_foreign_key "brand_categories", "brands"
  add_foreign_key "brand_categories", "categories"
  add_foreign_key "item_categories", "categories"
  add_foreign_key "item_categories", "items"
  add_foreign_key "items", "brands"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "user_roles", "users"
end
