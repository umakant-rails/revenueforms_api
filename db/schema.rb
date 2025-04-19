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

ActiveRecord::Schema[7.0].define(version: 2025_04_19_114206) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blank_forms", force: :cascade do |t|
    t.integer "form_category_id"
    t.string "eng_name"
    t.string "hindi_name"
    t.string "form_name"
    t.string "category"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_posts", force: :cascade do |t|
    t.integer "blog_subject_id"
    t.string "title"
    t.text "content"
    t.string "image"
    t.string "video"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_subjects", force: :cascade do |t|
    t.string "name"
    t.string "name_eng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "confirmation_codes", force: :cascade do |t|
    t.string "email"
    t.string "phone"
    t.string "code"
    t.datetime "expires_at"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_msgs", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "districts", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.string "name_eng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "form_categories", force: :cascade do |t|
    t.integer "form_section_id"
    t.string "hindi_name"
    t.string "eng_name"
    t.text "description"
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
    t.integer "village_id"
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
    t.boolean "karanda_aam"
    t.boolean "is_male", default: true
    t.boolean "is_applicant", default: false
    t.boolean "total_share_sold", default: false
    t.boolean "is_dead"
    t.date "death_date"
    t.boolean "is_nabalig"
    t.string "balee"
    t.integer "depth"
    t.string "relation_to_deceased"
    t.boolean "is_shareholder", default: false
    t.integer "parent_id"
    t.integer "request_id"
    t.integer "participant_type_id"
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
    t.integer "district_id"
    t.integer "tehsil_id"
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

  create_table "tehsils", force: :cascade do |t|
    t.integer "district_id"
    t.integer "code"
    t.string "name"
    t.string "name_eng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "traffic_logs", force: :cascade do |t|
    t.date "visit_date"
    t.string "ip_address"
    t.integer "visited_page"
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
    t.string "jti"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "villages", force: :cascade do |t|
    t.integer "district_id"
    t.integer "tehsil_id"
    t.integer "ri_code"
    t.string "ri"
    t.string "ri_eng"
    t.string "halka_number"
    t.string "halka_name"
    t.string "halka_name_eng"
    t.string "village_code"
    t.string "village"
    t.string "village_eng"
    t.string "bhucode_lr"
    t.string "lgd_code"
    t.string "data_available_since"
    t.string "map_available"
    t.string "ulb_name"
    t.string "village_type"
    t.string "is_khasra_available"
    t.integer "khasra_count"
    t.float "total_area_khasra"
    t.integer "map_parcel_count"
    t.float "total_area_map"
    t.boolean "aabaadi_survey"
    t.integer "ulnpin_plot"
    t.integer "ulpin_khasra"
    t.string "patwari_name"
    t.string "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visitor_logs", force: :cascade do |t|
    t.string "ip_address"
    t.string "page_url"
    t.date "visit_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
