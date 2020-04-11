Word = Struct.new(:self, :index)

class ClueCracker
  attr_reader :clue
  attr_reader :length

  def initialize(clue, length)
    @clue = clue
    @length = length
  end

  def solutions
    anagram_solutions.map(&:self).uniq
  end

  private

  def anagram_solutions
    anagrams.select do |anagram|
      synonyms.any? do |synonym|
        synonym.self == anagram.self && !anagram.indices.include?(synonym.index)
      end
    end.uniq
  end

  def anagrams
    (words_with_switches + [words]).map do |words|
      AnagramFinder.new(words, length).anagrams
    end.flatten.uniq
  end

  def synonyms
    @synonyms ||= words.map do |word|
      ThesaurusClient.new(word.self).synonyms.map do |synonym|
        Word.new(synonym, word.index)
      end
    end.flatten
  end

  def words_with_switches
    Switcher.new(words).words_with_switches
  end

  def words
    @words ||= clue.split(' ')
      .map { |word| word.downcase.gsub(/[^a-z]/, '') }
      .each_with_index.map { |word, index| Word.new(word, index) }
  end
end
