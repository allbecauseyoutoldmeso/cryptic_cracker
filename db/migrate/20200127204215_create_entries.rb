class CreateEntrys < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.string :word
      t.string :product
      t.string :abbreviations
      t.boolean :anagram_indicator, :boolean, default: false
      t.boolean :acrostic_indicator, :boolean, default: false
      t.index :product
    end
  end
end
