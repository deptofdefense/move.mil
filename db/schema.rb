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

ActiveRecord::Schema.define(version: 20171129161530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branch_of_service_contacts", force: :cascade do |t|
    t.text "branch"
    t.text "custsvc_org"
    t.text "custsvc_dsn"
    t.text "custsvc_tel_comm"
    t.text "custsvc_tel_tollfree"
    t.text "custsvc_email"
    t.text "custsvc_hours"
    t.text "custsvc_url"
    t.text "custsvc_facebook_url"
    t.text "claims_dsn"
    t.text "claims_tel_comm"
    t.text "claims_tel_tollfree"
    t.text "claims_fax_dsn"
    t.text "claims_fax_comm"
    t.text "claims_fax_tollfree"
    t.text "claims_email"
    t.text "claims_post"
    t.text "retiree_dsn"
    t.text "retiree_tel_comm"
    t.text "retiree_tel_tollfree"
    t.text "retiree_fax_dsn"
    t.text "retiree_fax_comm"
    t.text "retiree_fax_tollfree"
    t.text "retiree_email"
    t.text "retiree_post"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "claims_url"
  end

  create_table "entitlements", force: :cascade do |t|
    t.string "rank", null: false
    t.integer "total_weight_self", null: false
    t.integer "total_weight_self_plus_dependents"
    t.integer "pro_gear_weight"
    t.integer "pro_gear_weight_spouse"
    t.text "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faqs", force: :cascade do |t|
    t.text "question", null: false
    t.text "answer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "category"
  end

  create_table "household_good_categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "icon", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_household_good_categories_on_name", unique: true
  end

  create_table "household_goods", force: :cascade do |t|
    t.string "name"
    t.integer "weight"
    t.bigint "household_good_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["household_good_category_id"], name: "index_household_goods_on_household_good_category_id"
  end

  create_table "installations", force: :cascade do |t|
    t.text "name", null: false
    t.text "street_address"
    t.text "extended_address"
    t.text "locality"
    t.text "region"
    t.text "region_code"
    t.text "postal_code"
    t.text "country_name"
    t.text "country_code"
    t.float "latitude"
    t.float "longitude"
    t.json "email_addresses", default: []
    t.json "phone_numbers", default: []
    t.json "urls", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offices", force: :cascade do |t|
    t.text "type"
    t.bigint "shipping_office_id"
    t.text "name", null: false
    t.text "street_address"
    t.text "extended_address"
    t.text "locality"
    t.text "region"
    t.text "region_code"
    t.text "postal_code"
    t.text "country_name"
    t.text "country_code"
    t.float "latitude"
    t.float "longitude"
    t.json "email_addresses", default: []
    t.json "phone_numbers", default: []
    t.json "urls", default: []
    t.text "services", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "hours"
    t.text "note"
    t.index ["shipping_office_id"], name: "index_offices_on_shipping_office_id"
  end

  create_table "service_specific_posts", force: :cascade do |t|
    t.text "title"
    t.date "effective_at"
    t.text "branch"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tutorial_steps", force: :cascade do |t|
    t.bigint "tutorial_id"
    t.text "content", null: false
    t.text "image_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tutorial_id"], name: "index_tutorial_steps_on_tutorial_id"
  end

  create_table "tutorials", force: :cascade do |t|
    t.text "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "slug", null: false
  end

  create_table "zip_code_tabulation_areas", force: :cascade do |t|
    t.text "zip_code", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
  end

  add_foreign_key "household_goods", "household_good_categories"
  add_foreign_key "tutorial_steps", "tutorials"
end
