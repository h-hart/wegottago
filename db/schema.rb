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

ActiveRecord::Schema.define(:version => 20140307060705) do

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

  create_table "activities", :force => true do |t|
    t.integer  "theme_id"
    t.string   "title"
    t.string   "personal_quote"
    t.datetime "end_datetime"
    t.string   "location"
    t.text     "details"
    t.integer  "people_number"
    t.boolean  "people_ask_others"
    t.boolean  "gender_male"
    t.boolean  "gender_female"
    t.boolean  "status_single"
    t.boolean  "status_married"
    t.boolean  "status_in_relationship"
    t.boolean  "orientation_straight"
    t.boolean  "orientation_gay"
    t.boolean  "orientation_bisexual"
    t.boolean  "age_all"
    t.integer  "age_from"
    t.integer  "age_to"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.boolean  "kids"
    t.boolean  "no_kids"
    t.boolean  "expecting_kids"
    t.integer  "user_id"
    t.float    "lat"
    t.float    "lng"
  end

  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "activities_activity_categories", :force => true do |t|
    t.integer "activity_category_id"
    t.integer "activity_id"
  end

  create_table "activity_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "wide_image"
    t.string   "small_image"
  end

  create_table "activity_joins", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "activity_joins", ["activity_id"], :name => "index_activity_joins_on_activity_id"
  add_index "activity_joins", ["user_id"], :name => "index_activity_joins_on_user_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.float    "loc_lat"
    t.float    "loc_lng"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "comments", ["activity_id"], :name => "index_comments_on_activity_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "curiosities", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "curiosities", ["activity_id"], :name => "index_curiosities_on_activity_id"
  add_index "curiosities", ["user_id"], :name => "index_curiosities_on_user_id"

  create_table "friend_preferences", :force => true do |t|
    t.integer  "age_from"
    t.integer  "age_to"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "user_id"
    t.boolean  "gender_male"
    t.boolean  "gender_female"
    t.boolean  "status_single"
    t.boolean  "status_married"
    t.boolean  "status_in_relationship"
    t.boolean  "orientation_straight"
    t.boolean  "orientation_gay"
    t.boolean  "orientation_bisexual"
    t.boolean  "kids"
    t.boolean  "no_kids"
    t.boolean  "expecting_kids"
  end

  create_table "friends", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "approved",   :default => false
  end

  create_table "home_page_slider_photos", :force => true do |t|
    t.string "image"
    t.text   "caption"
  end

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               :default => false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                                  :null => false
    t.boolean  "is_read",                       :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], :name => "taggings_idx", :unique => true

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "theme_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "themes", :force => true do |t|
    t.string   "image"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "theme_category_id"
    t.integer  "user_id"
  end

  add_index "themes", ["theme_category_id"], :name => "index_themes_on_theme_category_id"
  add_index "themes", ["user_id"], :name => "index_themes_on_user_id"

  create_table "user_activities", :force => true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "is_read",        :default => false
  end

  add_index "user_activities", ["owner_id", "owner_type"], :name => "index_user_activities_on_owner_id_and_owner_type"
  add_index "user_activities", ["recipient_id", "recipient_type"], :name => "index_user_activities_on_recipient_id_and_recipient_type"
  add_index "user_activities", ["trackable_id", "trackable_type"], :name => "index_user_activities_on_trackable_id_and_trackable_type"

  create_table "user_notifications", :force => true do |t|
    t.boolean "friend_requests",  :default => false
    t.boolean "messages",         :default => false
    t.integer "user_id"
    t.boolean "social_organised"
  end

  add_index "user_notifications", ["social_organised"], :name => "index_user_notifications_on_social_organised"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "uid"
    t.string   "provider"
    t.string   "avatar"
    t.integer  "crop_x"
    t.integer  "crop_y"
    t.integer  "crop_h"
    t.integer  "crop_w"
    t.string   "last_name"
    t.integer  "zipcode"
    t.string   "occupation"
    t.string   "relationship_status"
    t.string   "looking_for"
    t.text     "about"
    t.string   "sex"
    t.string   "have_kids"
    t.string   "wants_kids"
    t.string   "ethnicity"
    t.string   "body_type"
    t.string   "height"
    t.string   "faith"
    t.string   "smoke"
    t.string   "drink"
    t.string   "orientation"
    t.boolean  "show_initials",          :default => true
    t.boolean  "age_private",            :default => false
    t.boolean  "visible_for_registered", :default => false
    t.date     "birthdate"
    t.string   "location",               :default => "",    :null => false
    t.float    "loc_lat"
    t.float    "loc_lng"
    t.datetime "last_activity_datatime"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["looking_for"], :name => "index_users_on_looking_for"
  add_index "users", ["relationship_status"], :name => "index_users_on_relationship_status"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["sex"], :name => "index_users_on_sex"
  add_index "users", ["visible_for_registered"], :name => "index_users_on_visible_for_registered"

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  add_foreign_key "notifications", "conversations", name: "notifications_on_conversation_id"

  add_foreign_key "receipts", "notifications", name: "receipts_on_notification_id"

end
