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

ActiveRecord::Schema.define(version: 2019_11_08_103000) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "prefecture", null: false
    t.string "below_city_or_ward", null: false
    t.string "below_house_number"
    t.integer "postal_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "prefecture", null: false
    t.string "below_city_or_ward", null: false
    t.string "below_house_number"
    t.integer "postal_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
  end

  create_table "credit_cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "number", null: false
    t.date "expiration_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merkers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "genre"
    t.integer "genre_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "product_image"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "seller_id", null: false
    t.string "name", null: false
    t.text "text", null: false
    t.integer "price", null: false
    t.string "categry"
    t.integer "status", null: false
    t.integer "brand"
    t.integer "size", null: false
    t.date "date", null: false
    t.integer "delivery_fee", null: false
    t.integer "delivery_method"
    t.integer "delivery_from"
    t.integer "estimated_delivery_date"
    t.integer "condition"
    t.integer "buyer_id"
    t.integer "finished", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "snscredentials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider"
    t.text "uid"
    t.integer "mid"
    t.text "token"
    t.text "pass_token"
    t.text "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_bookmarks_products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_product_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "user_id", null: false
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nick_name", null: false
    t.string "sur_name", null: false
    t.string "fr_name", null: false
    t.string "sur_name_yomi", null: false
    t.string "first_name_yomi", null: false
    t.string "introduction"
    t.integer "birthday_year"
    t.integer "birthday_manth"
    t.integer "birthday_day"
    t.string "tel_number", null: false
    t.string "certification", null: false
    t.integer "account"
    t.integer "sales_money"
    t.integer "point"
    t.string "icon_image"
    t.string "address_number", null: false
    t.string "address_ken", null: false
    t.string "address_city", null: false
    t.string "address_banch", null: false
    t.string "building_name"
    t.integer "evaluation", default: 0
    t.integer "exhibits_number", default: 0
    t.string "provider"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
