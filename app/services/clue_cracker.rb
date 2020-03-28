class ClueCracker

  attr_reader :clue
  attr_reader :length

  def initialize(clue, length)
    @clue = clue
    @length = length
  end

  def solutions
    anagrams.select { |anagram| synonyms.include?(anagram) }.uniq
  end

  private

  def synonyms
    @synonyms ||= words.map do |word|
      ThesaurusClient.new(word).synonyms
    end.flatten
  end

  def anagrams
    @anagrams ||= anagram_candidates.map do |candidate|
      AnagramCracker.new(candidate.split('')).anagrams
    end.flatten
  end

  def anagram_candidates
    words.select { |word| word.length == length }
  end

  def words
    @words ||= clue.split(' ').map(&:downcase).map { |word| word.gsub(/[^a-z]/, '') }
  end
end
