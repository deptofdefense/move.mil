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

ActiveRecord::Schema.define(version: 20180307204203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branch_of_service_contacts", force: :cascade do |t|
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
    t.bigint "branch_of_service_id"
    t.text "ppm_website"
    t.text "ppm_tel_comm"
    t.index ["branch_of_service_id"], name: "index_branch_of_service_contacts_on_branch_of_service_id"
  end

  create_table "branch_of_services", force: :cascade do |t|
    t.string "name", null: false
    t.integer "display_order", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counties", force: :cascade do |t|
    t.integer "state_id"
    t.string "abbr"
    t.string "name"
    t.string "county_seat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_counties_on_name"
    t.index ["state_id"], name: "index_counties_on_state_id"
  end

  create_table "dtod_zip3_distances", force: :cascade do |t|
    t.integer "orig_zip3"
    t.integer "dest_zip3"
    t.float "dist_mi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "full_packs", force: :cascade do |t|
    t.integer "schedule"
    t.int4range "weight_lbs"
    t.decimal "rate", precision: 7, scale: 2
    t.daterange "effective"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "full_unpacks", force: :cascade do |t|
    t.integer "schedule"
    t.decimal "rate", precision: 8, scale: 5
    t.daterange "effective"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "linehauls", force: :cascade do |t|
    t.int4range "dist_mi"
    t.int4range "weight_lbs"
    t.integer "rate"
    t.daterange "effective"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
  end

  create_table "locations", force: :cascade do |t|
    t.string "locatable_type"
    t.bigint "locatable_id"
    t.text "street_address"
    t.text "extended_address"
    t.text "locality"
    t.text "region"
    t.text "region_code"
    t.text "postal_code"
    t.text "country_name"
    t.text "country_code"
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locatable_type", "locatable_id"], name: "index_locations_on_locatable_type_and_locatable_id"
  end

  create_table "service_areas", force: :cascade do |t|
    t.integer "service_area"
    t.text "name"
    t.integer "services_schedule"
    t.decimal "linehaul_factor", precision: 7, scale: 2
    t.decimal "orig_dest_service_charge", precision: 7, scale: 2
    t.daterange "effective"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_specific_posts", force: :cascade do |t|
    t.text "title"
    t.date "effective_at"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "branch_of_service_id"
    t.index ["branch_of_service_id"], name: "index_service_specific_posts_on_branch_of_service_id"
  end

  create_table "shipping_offices", force: :cascade do |t|
    t.text "name", null: false
    t.json "email_addresses", default: []
    t.json "phone_numbers", default: []
    t.json "urls", default: []
    t.text "services", default: [], array: true
    t.text "hours"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shorthauls", force: :cascade do |t|
    t.int4range "cwt_mi"
    t.decimal "rate", precision: 7, scale: 2
    t.daterange "effective"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "abbr", limit: 2
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abbr"], name: "index_states_on_abbr"
  end

  create_table "top_tsp_by_channel_linehaul_discounts", force: :cascade do |t|
    t.text "orig"
    t.text "dest"
    t.daterange "tdl"
    t.decimal "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tdl"], name: "index_top_tsp_by_channel_linehaul_discounts_on_tdl"
  end

  create_table "transportation_offices", force: :cascade do |t|
    t.bigint "shipping_office_id"
    t.text "name", null: false
    t.json "email_addresses", default: []
    t.json "phone_numbers", default: []
    t.json "urls", default: []
    t.text "services", default: [], array: true
    t.text "hours"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_office_id"], name: "index_transportation_offices_on_shipping_office_id"
  end

  create_table "tutorial_steps", force: :cascade do |t|
    t.bigint "tutorial_id"
    t.text "content", null: false
    t.text "image_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "pro_tip"
    t.index ["tutorial_id"], name: "index_tutorial_steps_on_tutorial_id"
  end

  create_table "tutorials", force: :cascade do |t|
    t.text "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "slug", null: false
    t.integer "display_order"
  end

  create_table "weight_scales", force: :cascade do |t|
    t.text "name", null: false
    t.json "email_addresses", default: []
    t.json "phone_numbers", default: []
    t.json "urls", default: []
    t.text "hours"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zip3s", force: :cascade do |t|
    t.integer "zip3"
    t.text "basepoint_city"
    t.text "state"
    t.integer "service_area"
    t.text "rate_area"
    t.integer "region"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zip5_rate_areas", force: :cascade do |t|
    t.integer "zip5"
    t.text "rate_area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zipcodes", force: :cascade do |t|
    t.string "code"
    t.string "city"
    t.integer "state_id"
    t.integer "county_id"
    t.string "area_code"
    t.decimal "lat", precision: 15, scale: 10
    t.decimal "lon", precision: 15, scale: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_zipcodes_on_code"
    t.index ["county_id"], name: "index_zipcodes_on_county_id"
    t.index ["lat", "lon"], name: "index_zipcodes_on_lat_and_lon"
    t.index ["state_id"], name: "index_zipcodes_on_state_id"
  end

  add_foreign_key "branch_of_service_contacts", "branch_of_services"
  add_foreign_key "household_goods", "household_good_categories"
  add_foreign_key "service_specific_posts", "branch_of_services"
  add_foreign_key "transportation_offices", "shipping_offices"
  add_foreign_key "tutorial_steps", "tutorials"
end
