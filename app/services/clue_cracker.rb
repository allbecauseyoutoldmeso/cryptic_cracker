class ClueCracker
  attr_reader :clue
  attr_reader :length

  def initialize(clue, length)
    @clue = clue
    @length = length
  end

  def solutions
    could_be_anagram? ? anagrams.select { |anagram| synonyms.include?(anagram) }.uniq : []
  end

  private

  def could_be_anagram?
    Entry.where(word: words).any?(&:anagram_indicator)
  end

  def anagrams
    (words_with_abbreviations + [words]).map do |words|
      AnagramFinder.new(words, length).anagrams
    end.flatten
  end

  def synonyms
    @synonyms ||= words.map do |word|
      ThesaurusClient.new(word).synonyms
    end.flatten
  end

  def words_with_abbreviations
    AbbreviationSwitcher.new(words).words_with_switches
  end

  def words
    @words ||= clue.split(' ').map(&:downcase).map { |word| word.gsub(/[^a-z]/, '') }
  end
end
