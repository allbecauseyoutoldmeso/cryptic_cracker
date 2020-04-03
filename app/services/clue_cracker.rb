class ClueCracker
  attr_reader :clue
  attr_reader :length

  def initialize(clue, length)
    @clue = clue
    @length = length
  end

  def solutions
    (anagram_solutions + combiword_solutions).uniq - words
  end

  private

  def combiword_solutions
    (words_with_switches + [words]).map do |words|
      CombiwordFinder.new(words, length).combiwords
    end.flatten.uniq
  end

  def anagram_solutions
    could_be_anagram? ? anagrams.select { |anagram| synonyms.include?(anagram) }.uniq : []
  end

  def could_be_anagram?
    Entry.where(word: words).any?(&:anagram_indicator)
  end

  def anagrams
    (words_with_switches + [words]).map do |words|
      AnagramFinder.new(words, length).anagrams
    end.flatten
  end

  def synonyms
    @synonyms ||= words.map do |word|
      ThesaurusClient.new(word).synonyms
    end.flatten
  end

  def words_with_switches
    Switcher.new(words).words_with_switches
  end

  def words
    @words ||= clue.split(' ').map(&:downcase).map { |word| word.gsub(/[^a-z]/, '') }
  end
end
