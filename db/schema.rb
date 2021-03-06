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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160309004032) do

  create_table "article_topics", force: :cascade do |t|
    t.string   "name"
    t.string   "top_words"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "type"
    t.string   "puzzle_type"
    t.string   "text"
    t.integer  "redactions"
    t.boolean  "redacted"
    t.integer  "page"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "issue_id"
    t.integer  "author_id"
    t.text     "html"
    t.text     "answer"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "articles", ["issue_id"], name: "index_articles_on_issue_id"

  create_table "articles_watson_concepts", id: false, force: :cascade do |t|
    t.integer "article_id",        null: false
    t.integer "watson_concept_id", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string   "month"
    t.integer  "year"
    t.string   "volume"
    t.string   "volume_number"
    t.integer  "pdf_number"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "editor_id"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "role"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "department_id"
    t.text     "notes"
  end

  add_index "people", ["department_id"], name: "index_people_on_department_id"

  create_table "watson_concepts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
