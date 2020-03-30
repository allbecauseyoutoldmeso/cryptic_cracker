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
    entries.any?(&:anagram_indicator)
  end

  def anagrams
    @anagrams ||= anagram_candidates.map do |candidate|
      AnagramCracker.new(candidate.split('')).anagrams
    end.flatten
  end

  def synonyms
    @synonyms ||= words.map do |word|
      ThesaurusClient.new(word).synonyms
    end.flatten
  end

  def anagram_candidates
    (1..words.length).to_a.map do |num|
      words.combination(num).to_a.map(&:join).select do |string|
        string.length == length
      end
    end.flatten
  end

  def words_with_abbreviatons
    entries.where.not(abbreviations: nil)
  end

  def entries
    @entries ||= words.map { |word|  Entry.find_by(word: word) }.compact
  end

  def words
    @words ||= clue.split(' ').map(&:downcase).map { |word| word.gsub(/[^a-z]/, '') }
  end
end
