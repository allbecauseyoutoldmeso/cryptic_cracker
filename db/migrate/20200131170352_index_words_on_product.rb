class IndexWordsOnProduct < ActiveRecord::Migration[6.0]
  def change
    add_index :words, :product
  end
end
