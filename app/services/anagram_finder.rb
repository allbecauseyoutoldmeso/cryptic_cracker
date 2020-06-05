Anagram = Struct.new(:body, :indices)

class AnagramFinder
  attr_reader :words_with_switches
  attr_reader :length

  def initialize(words_with_switches, length)
    @words_with_switches = words_with_switches
    @length = length
  end

  def anagrams
    entries.map(&:word)
  end

  private

  def entries
    Entry.where(product: products)
  end

  def products
    all_anagram_candidates.map do |candidate|
      letters = candidate.map(&:body).join.split('')
      ProductCalculator.new(letters).product
    end
  end

  def all_anagram_candidates
    words_with_switches.map do |words|
      anagram_candidates(words)
    end.flatten(1).uniq
  end

  def anagram_candidates(words)
    (1..words.length).to_a.map do |num|
      words.combination(num).to_a.select do |combination|
        combination.map(&:body).join.length == length
      end
    end.flatten(1)
  end
end
