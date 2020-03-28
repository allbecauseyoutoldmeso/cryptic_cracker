class AddAnagramIndicatorToWords < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :anagram_indicator, :boolean, default: false
  end
end
