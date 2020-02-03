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

ActiveRecord::Schema.define(version: 2020_02_03_005558) do

  create_table "cliente_autonomos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "cuit"
    t.string "razon_social"
    t.string "nombre"
    t.integer "codigo_tipo_responsable"
    t.string "email"
    t.string "tipo_cliente"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cliente_dependientes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "cuil"
    t.string "nombre"
    t.integer "codigo_tipo_responsable"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "number_of_items"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sell_id", null: false
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_details_on_product_id"
    t.index ["sell_id"], name: "index_details_on_sell_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id", null: false
    t.decimal "sold_price", precision: 10
    t.bigint "sell_id"
    t.bigint "reservation_id"
    t.index ["product_id"], name: "index_items_on_product_id"
    t.index ["reservation_id"], name: "index_items_on_reservation_id"
    t.index ["sell_id"], name: "index_items_on_sell_id"
  end

  create_table "phone_numbers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "cliente_dependiente_id"
    t.bigint "cliente_autonomo_id"
    t.index ["cliente_autonomo_id"], name: "index_phone_numbers_on_cliente_autonomo_id"
    t.index ["cliente_dependiente_id"], name: "index_phone_numbers_on_cliente_dependiente_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.text "detail"
    t.decimal "cost_per_unit", precision: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservation_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "number_of_items"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "reservation_id", null: false
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_reservation_details_on_product_id"
    t.index ["reservation_id"], name: "index_reservation_details_on_reservation_id"
  end

  create_table "reservations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.boolean "sold", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "cliente_autonomo_id"
    t.bigint "cliente_dependiente_id"
    t.decimal "total", precision: 10
    t.index ["cliente_autonomo_id"], name: "index_reservations_on_cliente_autonomo_id"
    t.index ["cliente_dependiente_id"], name: "index_reservations_on_cliente_dependiente_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "sells", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.decimal "total", precision: 10
    t.bigint "cliente_autonomo_id"
    t.bigint "cliente_dependiente_id"
    t.string "tipo_cliente"
    t.index ["cliente_autonomo_id"], name: "index_sells_on_cliente_autonomo_id"
    t.index ["cliente_dependiente_id"], name: "index_sells_on_cliente_dependiente_id"
    t.index ["user_id"], name: "index_sells_on_user_id"
  end

  create_table "telefono_numeros", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "numero"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "details", "products"
  add_foreign_key "details", "sells"
  add_foreign_key "items", "products"
  add_foreign_key "items", "reservations"
  add_foreign_key "items", "sells"
  add_foreign_key "phone_numbers", "cliente_autonomos"
  add_foreign_key "phone_numbers", "cliente_dependientes"
  add_foreign_key "reservation_details", "products"
  add_foreign_key "reservation_details", "reservations"
  add_foreign_key "reservations", "cliente_autonomos"
  add_foreign_key "reservations", "cliente_dependientes"
  add_foreign_key "reservations", "users"
  add_foreign_key "sells", "cliente_autonomos"
  add_foreign_key "sells", "cliente_dependientes"
  add_foreign_key "sells", "users"
end
