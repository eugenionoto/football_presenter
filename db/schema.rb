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

ActiveRecord::Schema.define(version: 2020_10_21_013813) do

  create_table "football_players", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "team"
    t.string "position"
    t.integer "rushing_attempts"
    t.float "rushing_attempts_per_game"
    t.integer "yards"
    t.float "yards_per_game"
    t.float "average_yards"
    t.integer "total_rushing_touchdown"
    t.string "longest_rush"
    t.string "longest_rush_sortable_field"
    t.integer "rushing_first_down"
    t.float "rushing_first_down_percent"
    t.integer "rushing_20"
    t.integer "rushing_40"
    t.integer "rushing_fumble"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_football_players_on_name", unique: true
  end

end
