class Switcher
  attr_reader :words

  def initialize(words)
    @words = words
  end

  def words_with_switches
    combinations_of_switches.map do |switches|
      words.each_with_index.map do |word, index|
        switch = switches.find { |switch| index == switch[0] }
        switch.present? ? switch[1] : word
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
    @switches ||= words.each_with_index.map do |word, index|
      synonyms = ThesaurusClient.new(word).synonyms
      abbreviations = Entry.where(word: word)[0].try(:abbreviations).try(:split, ',') || []
      (synonyms + abbreviations).map do |alternative|
        [index, alternative]
      end
    end.flatten(1)
  end
end
