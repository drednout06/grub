# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120907091101) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "addresses", :force => true do |t|
    t.string   "city"
    t.string   "district"
    t.string   "house"
    t.string   "porch"
    t.string   "floor"
    t.string   "doorphone"
    t.string   "comment"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "korpus"
    t.string   "phone_number"
    t.string   "street"
  end

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "deliverabilities", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "district_id"
    t.integer  "fee"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "dishes", :force => true do |t|
    t.string   "name"
    t.integer  "menu_id"
    t.text     "description"
    t.integer  "price"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "district_translations", :force => true do |t|
    t.integer  "district_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "district_translations", ["district_id"], :name => "index_district_translations_on_district_id"
  add_index "district_translations", ["locale"], :name => "index_district_translations_on_locale"

  create_table "districts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.integer  "city_id"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "dish_id"
    t.integer  "cart_id"
    t.integer  "quantity",   :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "order_id"
  end

  create_table "menus", :force => true do |t|
    t.string   "name"
    t.integer  "restaurant_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "address_id"
    t.datetime "delivery_time"
    t.integer  "change_from"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "restaurant_id"
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "minimum_order"
    t.integer  "user_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "title"
    t.integer  "average_delivery_time"
    t.text     "description"
    t.integer  "delivery_fee"
    t.integer  "city_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.boolean  "admin",                  :default => false, :null => false
    t.boolean  "restaurateur",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
