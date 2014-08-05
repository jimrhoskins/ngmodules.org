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

ActiveRecord::Schema.define(:version => 20131027014349) do

  create_table "blog_posts", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.datetime "published_at"
    t.boolean  "published"
    t.text     "content_markdown"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.string   "github_repo"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "homepage"
    t.string   "description"
    t.text     "readme_markdown"
    t.integer  "owner_id"
    t.integer  "submitter_id"
    t.integer  "uses_count",      :default => 0
    t.string   "download_url"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "nickname"
    t.string   "email"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "admin"
    t.string   "avatar_url"
  end

  create_table "uses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "package_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
