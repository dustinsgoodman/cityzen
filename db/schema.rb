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

ActiveRecord::Schema.define(:version => 20130223022611) do

  create_table "petitions", :force => true do |t|
    t.string  "title"
    t.integer "num_signatures"
    t.integer "author_id"
    t.integer "num_goal"
    t.float   "longitude"
    t.float   "latitude"
    t.text    "content"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",                                            :null => false
    t.string   "middle_name"
    t.string   "last_name",                                             :null => false
    t.string   "phone_number"
    t.string   "login",               :limit => 20
    t.string   "email",               :limit => 100,                    :null => false
    t.string   "address"
    t.string   "address2"
    t.string   "city",                                                  :null => false
    t.string   "state",                                                 :null => false
    t.string   "zip",                                                   :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "profile_pic"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                                     :null => false
    t.string   "single_access_token",                                   :null => false
    t.string   "perishable_token",                                      :null => false
    t.integer  "login_count",                        :default => 0,     :null => false
    t.integer  "failed_login_count",                 :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "password_reset_at"
    t.datetime "email_confimred_at"
    t.datetime "tos_agreed_at"
    t.boolean  "admin",                              :default => false
    t.boolean  "moderator",                          :default => false
    t.boolean  "event_coord",                        :default => false
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["oauth_token"], :name => "index_users_on_oauth_token"

end
