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

ActiveRecord::Schema.define(:version => 20131120172344) do

  create_table "email_verifications", :force => true do |t|
    t.integer  "user_id"
    t.string   "code"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "active_link", :default => true
  end

  add_index "email_verifications", ["code"], :name => "index_email_verifications_on_code"

  create_table "people", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "people", ["user_id"], :name => "index_people_on_user_id", :unique => true

  create_table "profiles", :force => true do |t|
    t.string   "first_name", :limit => 127
    t.string   "last_name",  :limit => 127
    t.date     "birthday"
    t.string   "gender"
    t.boolean  "searchable",                :default => true
    t.integer  "person_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "profiles", ["first_name", "last_name", "searchable"], :name => "index_profiles_on_first_name_and_last_name_and_searchable"
  add_index "profiles", ["first_name", "searchable"], :name => "index_profiles_on_first_name_and_searchable"
  add_index "profiles", ["last_name", "searchable"], :name => "index_profiles_on_last_name_and_searchable"
  add_index "profiles", ["person_id"], :name => "index_profiles_on_person_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                      :default => false
    t.boolean  "active",                     :default => false
    t.boolean  "verified_email",             :default => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "confirmation_token"
    t.datetime "confirmation_token_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
