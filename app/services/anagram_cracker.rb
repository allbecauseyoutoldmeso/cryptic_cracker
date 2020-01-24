class AnagramCracker

  attr_reader :letters

  def initialize(letters)
    @letters = letters
  end

  def words
    potential_words.select { |word| has_definition?(word) }
  end

  private

  def has_definition?(word)
    DictionaryClient.new(word).definitions.any?
  end

  def potential_words
    permutations.map(&:join)
  end

  def permutations
    letters.permutation.to_a
  end
end
