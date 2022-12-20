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

ActiveRecord::Schema[7.0].define(version: 2022_12_20_211817) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "card_instances", force: :cascade do |t|
    t.string "flavour_text"
    t.bigint "expansion_id", null: false
    t.bigint "card_id", null: false
    t.integer "rarity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["card_id"], name: "index_card_instances_on_card_id"
    t.index ["expansion_id"], name: "index_card_instances_on_expansion_id"
    t.index ["uuid"], name: "index_card_instances_on_uuid", unique: true
  end

  create_table "card_types", force: :cascade do |t|
    t.string "value", array: true
    t.integer "type_scope"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["value"], name: "index_card_types_on_value", unique: true
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "power", limit: 2
    t.string "toughness", limit: 2
    t.text "text"
    t.string "subtypes", array: true
    t.string "manacost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "types", array: true
    t.integer "mana_value"
    t.string "supertypes", array: true
    t.index ["name"], name: "index_cards_on_name", unique: true
  end

  create_table "expansions", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "card_num"
    t.date "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_expansions_on_code", unique: true
    t.index ["name"], name: "index_expansions_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 20
    t.string "password_digest"
    t.boolean "is_admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "card_instances", "cards"
  add_foreign_key "card_instances", "expansions"
end
