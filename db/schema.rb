# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_06_220554) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "command_records", force: :cascade do |t|
    t.string "user_id"
    t.string "aggregate_id"
    t.string "command_type", null: false
    t.text "command_json", null: false
    t.datetime "created_at", null: false
  end

  create_table "event_records", force: :cascade do |t|
    t.string "aggregate_id", null: false
    t.integer "sequence_number", null: false
    t.string "event_type", null: false
    t.text "event_json", null: false
    t.integer "command_record_id", null: false
    t.integer "stream_record_id", null: false
    t.datetime "created_at", null: false
    t.index "aggregate_id, sequence_number, (\nCASE event_type\n    WHEN 'Sequent::Core::SnapshotEvent'::text THEN 0\n    ELSE 1\nEND)", name: "unique_event_per_aggregate", unique: true
    t.index ["aggregate_id", "sequence_number"], name: "snapshot_events", order: { sequence_number: :desc }, where: "((event_type)::text = 'Sequent::Core::SnapshotEvent'::text)"
    t.index ["command_record_id"], name: "index_event_records_on_command_record_id"
    t.index ["created_at"], name: "index_event_records_on_created_at"
    t.index ["event_type"], name: "index_event_records_on_event_type"
  end

  create_table "stream_records", force: :cascade do |t|
    t.string "aggregate_type", null: false
    t.string "aggregate_id", null: false
    t.integer "snapshot_threshold"
    t.datetime "created_at", null: false
    t.index ["aggregate_id"], name: "index_stream_records_on_aggregate_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "aggregate_id"
    t.string "email"
    t.string "fullname"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
