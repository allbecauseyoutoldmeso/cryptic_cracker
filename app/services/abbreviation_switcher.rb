class AbbreviationSwitcher
  attr_reader :words

  def initialize(words)
    @words = words
  end

  def words_with_switches
    combinations_of_switches.map do |switches|
      words.map do |word|
        switch = switches.find { |switch| word == switch[0] }
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
    @switches ||= words.map do |word|
      abbreviations = Entry.find_by(word: word).try(:abbreviations).try(:split, ',') || []
      abbreviations.map do |abbreviation|
        [word, abbreviation]
      end
    end.flatten(1)
  end
end
