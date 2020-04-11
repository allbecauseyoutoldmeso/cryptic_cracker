Anagram = Struct.new(:self, :indices)

class AnagramFinder
  attr_reader :words
  attr_reader :length

  def initialize(words, length)
    @words = words
    @length = length
  end

  def anagrams
    anagram_candidates.map do |candidate|
      letters = candidate.map(&:self).join.split('')
      AnagramCracker.new(letters).anagrams.map do |anagram|
        Anagram.new(anagram, candidate.map(&:index))
      end
    end.flatten
  end

  private

  def anagram_candidates
    (1..words.length).to_a.map do |num|
      words.combination(num).to_a.select do |combination|
        combination.map(&:self).join.length == length
      end
    end.flatten(1)
  end
end
