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

ActiveRecord::Schema.define(version: 20190923160609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.integer "route_id"
    t.string "agency_id"
    t.string "route_short_name"
    t.string "route_long_name"
    t.integer "route_type"
    t.string "transport_type"
    t.integer "circular"
    t.integer "urban"
    t.integer "night"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_id"], name: "index_routes_on_route_id"
  end

  create_table "shapes", force: :cascade do |t|
    t.string "shape_id"
    t.decimal "shape_pt_lat"
    t.decimal "shape_pt_lon"
    t.integer "shape_pt_sequence"
    t.float "shape_dist_traveled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shape_id"], name: "index_shapes_on_shape_id"
  end

  create_table "stop_times", force: :cascade do |t|
    t.integer "trip_id"
    t.string "arrival_time"
    t.string "departure_time"
    t.integer "stop_id"
    t.integer "stop_sequence"
    t.string "shape_id"
    t.float "shape_dist_travelled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stop_id"], name: "index_stop_times_on_stop_id"
    t.index ["trip_id"], name: "index_stop_times_on_trip_id"
  end

  create_table "stops", force: :cascade do |t|
    t.integer "stop_id"
    t.integer "stop_code"
    t.string "stop_name"
    t.decimal "stop_lat"
    t.decimal "stop_lon"
    t.integer "location_type"
    t.integer "wheelchair_boarding"
    t.string "transport_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stop_id"], name: "index_stops_on_stop_id"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "route_id"
    t.integer "service_id"
    t.integer "trip_id"
    t.integer "direction_id"
    t.string "shape_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_id"], name: "index_trips_on_route_id"
    t.index ["shape_id"], name: "index_trips_on_shape_id"
    t.index ["trip_id"], name: "index_trips_on_trip_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.datetime "timestamp"
    t.string "position"
    t.integer "direction"
    t.integer "routeId"
    t.integer "vehicleLabel"
    t.integer "velocity"
    t.integer "vehicleId"
    t.integer "orderNumber"
    t.string "licensePlate"
    t.integer "directionId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
