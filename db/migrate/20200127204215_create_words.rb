class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :written_form
      t.integer :product
    end
  end
end
