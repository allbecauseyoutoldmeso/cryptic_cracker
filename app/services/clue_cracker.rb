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
    anagram_indicators.any?
  end

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
    (1..words.length - 1).to_a.map do |num|
      words.combination(num).to_a.map(&:join).select do |string|
        string.length == length
      end
    end.flatten
  end

  def anagram_indicators
    @anagram_indicators ||= words.select { |word| Word.find_by(written_form: word).try(:anagram_indicator) }
  end

  def words
    @words ||= clue.split(' ').map(&:downcase).map { |word| word.gsub(/[^a-z]/, '') }
  end
end
