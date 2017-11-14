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

ActiveRecord::Schema.define(version: 20171113182219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "country_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_images", force: :cascade do |t|
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.index ["item_id"], name: "index_item_images_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "available", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
  end

  create_table "order_line_statuses", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_lines", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "item_id"
    t.integer "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_line_status_id"
    t.integer "quantity_fulfilled"
    t.index ["item_id"], name: "index_order_lines_on_item_id"
    t.index ["order_id"], name: "index_order_lines_on_order_id"
    t.index ["order_line_status_id"], name: "index_order_lines_on_order_line_status_id"
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "total"
    t.text "notes"
    t.bigint "user_id"
    t.bigint "order_status_id"
    t.string "address"
    t.string "city"
    t.bigint "state_id"
    t.bigint "country_id"
    t.integer "zip"
    t.string "stripe_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address_two"
    t.string "first_name"
    t.string "last_name"
    t.index ["country_id"], name: "index_orders_on_country_id"
    t.index ["order_status_id"], name: "index_orders_on_order_status_id"
    t.index ["state_id"], name: "index_orders_on_state_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "state_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.bigint "state_id"
    t.bigint "country_id"
    t.integer "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.bigint "phone"
    t.boolean "admin", default: false
    t.string "address_two"
    t.index ["country_id"], name: "index_users_on_country_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["state_id"], name: "index_users_on_state_id"
  end

  add_foreign_key "item_images", "items"
  add_foreign_key "order_lines", "items"
  add_foreign_key "order_lines", "order_line_statuses"
  add_foreign_key "order_lines", "orders"
  add_foreign_key "orders", "countries"
  add_foreign_key "orders", "order_statuses"
  add_foreign_key "orders", "states"
  add_foreign_key "orders", "users"
  add_foreign_key "users", "countries"
  add_foreign_key "users", "states"
end
