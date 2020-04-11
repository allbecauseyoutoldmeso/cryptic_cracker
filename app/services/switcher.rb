class Switcher
  attr_reader :words

  def initialize(words)
    @words = words
  end

  def words_with_switches
    combinations_of_switches.map do |switches|
      words.map do |word|
        switch = switches.find { |switch| word.index == switch.index }
        switch.present? ? switch : word
      end
    end.uniq
  end

  private

  def combinations_of_switches
    (1..switches.length).to_a.map do |num|
      switches.combination(num).to_a
    end.flatten(1)
  end

  def switches
    @switches ||= words.map do |word|
      synonyms = ThesaurusClient.new(word.self).synonyms
      abbreviations = Entry.where(word: word.self)[0].try(:abbreviations).try(:split, ',') || []
      (synonyms + abbreviations).map do |alternative|
        Word.new(alternative, word.index)
      end
    end.flatten(1)
  end
end
