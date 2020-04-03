class AnagramFinder
  attr_reader :words
  attr_reader :length

  def initialize(words, length)
    @words = words
    @length = length
  end

  def anagrams
    anagram_candidates.map do |candidate|
      AnagramCracker.new(candidate.split('')).anagrams
    end.flatten
  end

  private

  def anagram_candidates
    (1..words.length).to_a.map do |num|
      words.combination(num).to_a.map(&:join).select do |string|
        string.length == length
      end
    end.flatten
  end
end
