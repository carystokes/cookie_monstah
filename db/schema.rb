
ActiveRecord::Schema.define(version: 20161004181333) do

  enable_extension "plpgsql"

  create_table "recipes", force: :cascade do |t|
    t.text     "ingredients",  null: false
    t.text     "instructions", null: false
    t.string   "title",        null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating",     null: false
    t.text     "body"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
