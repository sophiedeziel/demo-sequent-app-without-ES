class CreateEventStore < ActiveRecord::Migration[6.0]
  def change

    create_table "event_records", :force => :cascade do |t|
      t.string "aggregate_id", null: false
      t.integer "sequence_number", null: false
      t.string "event_type", null: false
      t.text "event_json", null: false
      t.integer "command_record_id", null: false
      t.integer "stream_record_id", null: false

      t.datetime "created_at", null: false

      if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "postgresql"
        t.index "aggregate_id, sequence_number, (\nCASE event_type\n    WHEN 'Sequent::Core::SnapshotEvent'::text THEN 0\n    ELSE 1\nEND)", name: "unique_event_per_aggregate", unique: true
        t.index ["aggregate_id", "sequence_number"], name: "snapshot_events", order: { sequence_number: :desc }, where: "((event_type)::text = 'Sequent::Core::SnapshotEvent'::text)"
      end

      t.index ["command_record_id"], name: "index_event_records_on_command_record_id"
      t.index ["created_at"], name: "index_event_records_on_created_at"
      t.index ["event_type"], name: "index_event_records_on_event_type"
    end

    create_table "command_records", force: :cascade do |t|
      t.string "user_id"
      t.string "aggregate_id"
      t.string "command_type", null: false
      t.text "command_json", null: false

      t.datetime "created_at", null: false
    end

    create_table "stream_records", force: :cascade do |t|
      t.string "aggregate_type", null: false
      t.string "aggregate_id", null: false
      t.integer "snapshot_threshold"

      t.datetime "created_at", null: false

      t.index ["aggregate_id"], name: "index_stream_records_on_aggregate_id", unique: true
    end

  end
end
