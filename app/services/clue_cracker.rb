class ClueCracker
  attr_reader :clue
  attr_reader :length

  def initialize(clue, length)
    @clue = clue
    @length = length
  end

  def solutions
    anagram_solutions.uniq
  end

  private

  def anagram_solutions
    anagrams.select do |anagram|
      words.any? do |word|
        word.synonyms.any? do |synonym|
          synonym == anagram
        end
      end
    end.uniq
  end

  def anagrams
    AnagramFinder.new(words_with_switches, length).anagrams
  end

  def words_with_switches
    Switcher.new(words).words_with_switches + [words]
  end

  def words
    @words ||= clue.split(' ')
      .map { |word| word.downcase.gsub(/[^a-z]/, '') }
      .each_with_index.map { |word, index| Word.new(word, index) }
  end
end
