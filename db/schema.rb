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

ActiveRecord::Schema[7.0].define(version: 2023_08_11_185958) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blank_forms", force: :cascade do |t|
    t.integer "form_category_id"
    t.string "eng_name"
    t.string "hindi_name"
    t.string "category"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "form_categories", force: :cascade do |t|
    t.integer "form_section_id"
    t.string "hindi_name"
    t.string "eng_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "form_sections", force: :cascade do |t|
    t.string "hindi_name"
    t.string "eng_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "khasra_battanks", force: :cascade do |t|
    t.integer "khasra_id"
    t.string "new_khasra"
    t.float "rakba"
    t.integer "request_id"
    t.string "participant_ids"
    t.string "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "khasra_participants", force: :cascade do |t|
    t.string "khasra_id"
    t.integer "participant_id"
    t.string "rakba"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "khasras", force: :cascade do |t|
    t.string "khasra"
    t.string "rakba"
    t.string "sold_rakba"
    t.string "unit"
    t.integer "request_id"
    t.integer "village_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.string "payment_id"
    t.string "order_id"
    t.string "signature"
    t.integer "amount"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participant_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.string "relation"
    t.string "gaurdian"
    t.string "address"
    t.boolean "is_dead"
    t.date "death_date"
    t.boolean "is_nabalig"
    t.string "balee"
    t.integer "parent_id"
    t.integer "request_id"
    t.integer "depth"
    t.string "relation_to_deceased"
    t.boolean "is_shareholder", default: false
    t.integer "participant_type_id"
    t.boolean "total_share_sold", default: false
    t.boolean "is_applicant", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_transactions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "transactionable_id"
    t.string "transactionable_type"
    t.string "app_number"
    t.integer "amount"
    t.integer "credit"
    t.integer "debit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.string "title"
    t.integer "request_type_id"
    t.integer "village_id"
    t.string "registry_number"
    t.date "registry_date"
    t.string "year"
    t.integer "user_id"
    t.boolean "payment_done", default: false
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username"
    t.string "mobile"
    t.string "encrypted_password", default: "", null: false
    t.integer "role_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_order_display", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "villages", force: :cascade do |t|
    t.string "district"
    t.string "district_eng"
    t.string "tehsil"
    t.string "tehsil_eng"
    t.string "ri"
    t.string "halka_number"
    t.string "halka_name"
    t.string "village_code"
    t.string "village"
    t.string "village_eng"
    t.string "bhucode_lr"
    t.string "lgd_code"
    t.integer "total_khasra"
    t.integer "total_area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
