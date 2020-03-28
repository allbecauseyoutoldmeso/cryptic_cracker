class ClueCracker

  attr_reader :clue
  attr_reader :length

  def initialize(clue, length)
    @clue = clue
    @length = length
  end

  def solutions
    anagrams.select { |anagram| synonyms.include?(anagram) }.uniq if is_anagram
  end

  private

  def is_anagram
    anagram_indicators.any?
  end

  def synonyms
    @synonyms ||= non_anagram_indicators.map do |word|
      ThesaurusClient.new(word).synonyms
    end.flatten
  end

  def anagrams
    @anagrams ||= anagram_candidates.map do |candidate|
      AnagramCracker.new(candidate.split('')).anagrams
    end.flatten
  end

  def anagram_candidates
    non_anagram_indicators.select { |word| word.length == length }
  end

  def non_anagram_indicators
    @non_anagram_indicators ||= words - anagram_indicators
  end

  def anagram_indicators
    @anagram_indicators ||= words.select { |word| Word.find_by(written_form: word).try(:anagram_indicator) }
  end

  def words
    @words ||= clue.split(' ').map(&:downcase).map { |word| word.gsub(/[^a-z]/, '') }
  end
end
