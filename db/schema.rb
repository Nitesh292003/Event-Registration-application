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

ActiveRecord::Schema[8.0].define(version: 2025_04_29_101859) do
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

  create_table "discount_code_transactions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "discount_code_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_code_id"], name: "index_discount_code_transactions_on_discount_code_id"
    t.index ["event_id"], name: "index_discount_code_transactions_on_event_id"
    t.index ["user_id"], name: "index_discount_code_transactions_on_user_id"
  end

  create_table "discount_codes", force: :cascade do |t|
    t.string "code"
    t.integer "discount_percentage"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "max_uses"
    t.integer "used_count", default: 0
    t.string "status", default: "active"
    t.integer "event_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_discount_codes_on_event_id"
    t.index ["user_id"], name: "index_discount_codes_on_user_id"
  end

  create_table "disocunt_codes", force: :cascade do |t|
    t.string "code"
    t.integer "discount_percentage"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "max_uses"
    t.integer "used_count", default: 0
    t.integer "event_id"
    t.integer "user_id"
    t.string "status", default: "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_disocunt_codes_on_event_id"
    t.index ["user_id"], name: "index_disocunt_codes_on_user_id"
  end

  create_table "event_bookings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.integer "number_of_tickets", null: false
    t.string "status", default: "pending"
    t.datetime "booking_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total_price", precision: 10, scale: 2
    t.index ["event_id"], name: "index_event_bookings_on_event_id"
    t.index ["user_id"], name: "index_event_bookings_on_user_id"
  end

  create_table "event_types", force: :cascade do |t|
    t.string "event_type_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "organizer_name"
    t.string "event_name"
    t.string "description"
    t.datetime "event_date"
    t.datetime "event_end_date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "capacity"
    t.integer "registered_count", default: 0
    t.integer "base_price"
    t.integer "early_bird_price"
    t.datetime "early_bird_end_time"
    t.string "status", default: "upcoming"
    t.integer "user_id"
    t.integer "venue_id"
    t.integer "event_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_type_id"], name: "index_events_on_event_type_id"
    t.index ["user_id"], name: "index_events_on_user_id"
    t.index ["venue_id", "event_type_id"], name: "index_events_on_venue_id_and_event_type_id"
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "event_booking_id", null: false
    t.decimal "total_amount", precision: 10, scale: 2
    t.string "payment_status"
    t.datetime "payment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_booking_id"], name: "index_payments_on_event_booking_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "surname"
    t.string "email"
    t.string "phone_no"
    t.string "password_digest"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "venues", force: :cascade do |t|
    t.string "venue_name"
    t.string "address"
    t.string "state"
    t.string "country"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "discount_code_transactions", "discount_codes"
  add_foreign_key "discount_code_transactions", "events"
  add_foreign_key "discount_code_transactions", "users"
  add_foreign_key "discount_codes", "events"
  add_foreign_key "discount_codes", "users"
  add_foreign_key "disocunt_codes", "events"
  add_foreign_key "disocunt_codes", "users"
  add_foreign_key "event_bookings", "events"
  add_foreign_key "event_bookings", "users"
  add_foreign_key "events", "event_types"
  add_foreign_key "events", "users"
  add_foreign_key "events", "venues"
  add_foreign_key "payments", "event_bookings"
  add_foreign_key "users", "roles"
end
