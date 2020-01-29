ActiveRecord::Schema.define(version: 2020_01_27_204215) do

  create_table "words", force: :cascade do |t|
    t.string "written_form"
    t.integer "product"
  end
end
